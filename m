Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIKnvVhc"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57D112
	for <linux-mmc@vger.kernel.org>; Mon, 20 Nov 2023 04:41:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4094301d505so13954445e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Nov 2023 04:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700484093; x=1701088893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8AXsr2V1Nn99aVImVtZoW3sMIHdQmkbw8PzuLmDcWY=;
        b=qIKnvVhcEbRRdHEaPKUlb9qI16aVDXdqvcKkEqknfoc1+2kjlrShcIr5pAZ79rFl1Q
         Y7gRuxfy8zcZvkHr0wJWmf/E1wvQUZhiptlc933AqGIAar2kWYwWDR9Ddc4mvu+fC22e
         VnlsTtJHJxJFkQk+PXVe1wsalgkMNUoRGVr/UtaTYvCMN7vwjAtAgFgnpoOPTXJ8e7+5
         O09zjnMVJ/DQk5mJXMwJhBWhwNSprjTpaoGVgaPR37kcFoTOujI2U3lE0vACUhCP4boI
         zPw/WRNJ1m3z51OPX9p73Nca0wGb93c17XyY2O2siZ5c99SGSHJBQSP+rlD3n2sUf38M
         9m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700484093; x=1701088893;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8AXsr2V1Nn99aVImVtZoW3sMIHdQmkbw8PzuLmDcWY=;
        b=Kizu2j8zD+uY/8yFwSgHyz48NDbZpTXCIsKvDRgJCwb28gVLOvL+hIx48THEOBer6V
         ocJcNgxVoSM83tBXuzum91wvOxw4Ful+NjIcDFkXzsHftd4ZZs13lHAw5phdLxNNRsH8
         WQa0oQgJ8J+H29ygssfDveVolGo9ecVkCx4Z15wc7XKjtxWljgTO3ahNN5VqVvjrQEYy
         jikQXnxcw0BPaVZnG/kvExrdi3U1MYneGQtS9ku923E2Ls14b1B4FPPQaMDx9+fAyMbv
         GQX3JBS55/BfS26zs9Ghl/U9gjtOldTiTRr57/Hc7edUmUk7Bnt0ZfEQlN+iUwUpz0/W
         XVOw==
X-Gm-Message-State: AOJu0YxpYl0vYc+PTbugysy16AXrQ0SFGVijOX/4rkDmMcMZhSh5J16N
	c6OWXLo9WJDlqqI6Mx6BLKW2YA==
X-Google-Smtp-Source: AGHT+IEDPveRKioBaTK0ucDVCB0HrPLb6ELw25Th3wyqejAxtPCbP030mazFVRgu3eLqvgQilyx+jA==
X-Received: by 2002:a05:600c:3555:b0:407:8f23:cf3 with SMTP id i21-20020a05600c355500b004078f230cf3mr6398033wmq.26.1700484093362;
        Mon, 20 Nov 2023 04:41:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b0040596352951sm18088815wmb.5.2023.11.20.04.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 04:41:31 -0800 (PST)
Message-ID: <062c2a9f-238c-440e-86d3-8a2ed3b4b7c1@linaro.org>
Date: Mon, 20 Nov 2023 13:41:28 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc
 driver
To: =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
Cc: "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "briannorris@chromium.org" <briannorris@chromium.org>,
 "doug@schmorgal.com" <doug@schmorgal.com>,
 "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
 "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
 "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
References: <20231109082043.27147-1-jyanchou@realtek.com>
 <20231109082043.27147-5-jyanchou@realtek.com>
 <71ca3812-9226-4a83-a655-78401e4ed33f@linaro.org>
 <f471b7e2d1b54e05a92d70f6479305e2@realtek.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f471b7e2d1b54e05a92d70f6479305e2@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/11/2023 11:50, Jyan Chou [周芷安] wrote:
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  reset-names:
>>> +    const: reset
> 
>> And here you describe the item? The only place when it is not needed?
>> Drop entierly.
> 
> does it means we need to drop it? But we need this to determine whether to
> 
> setup a reset control or not, if we didn't add it in our bindings, check patch will
> 
> show error. Did I misunderstand your meaning? Thanks.

Please drop entirely reset-names. From the bindings, so obviously from
the DTS and driver code as well. I do not ask to drop resets, just
reset-names.

Best regards,
Krzysztof

