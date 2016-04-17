class String
    def real_length
        self.length + (self.bytes.count - self.length) / 2
    end
end

