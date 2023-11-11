Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086AEBB
	for <linux-mmc@vger.kernel.org>; Sat, 11 Nov 2023 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VpwjBREL"
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802563C3D
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 16:07:48 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5b99bfca064so1928563a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 16:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699661268; x=1700266068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZOLx6piJ84WzMT/cgtNzYXyAwxaq83dr7vI8k16AOs=;
        b=VpwjBRELtn3hl/lwknWR2q5pKLw7AUqGVcSQIfIb3qH/Qp95CSael2LxODcQZFRqy/
         j7gzlGE/my7dcbuTVo+zsF2j61gF+6j0bUGh3AdBDsMVgiP21fvNWp0C9huXKnVov/yB
         GkrhYD1E91olWVUjdLeto15o49XcVEi2SmCsPlV16hMpIzDX84m2K2nlvaAqSOD6zLBY
         M0ZX0Iea1/MmQ8CwaWx3rENOe0xmnaGhuClBqSULxm9Lv8LGQwBcM5+eSnf0jA9c3R2D
         NG4a0UsXXwAYY8JEZfzxhifRoxxd9y8P2JWVWbmC31KAEbq9mrB0o5fr5u1vi3uo6I3E
         8dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699661268; x=1700266068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZOLx6piJ84WzMT/cgtNzYXyAwxaq83dr7vI8k16AOs=;
        b=A31DDqGtqppSY0cZ/wP0qALWvBO2cGBTGJmb4OATQg3oHL1CyLqHerxWN9PxSQ6dDB
         gmpKL7hjYiqzntsvyWKfIDH68xenUpJm9o9CSEl49LAxvOd0nIIBNOciEQliYqrI11qz
         wAdQN2LkRQLpbiBIjkJ+UtEjiQWcs0imdMSe3deKCoq03OhXqjaLa0WRFfGNthHaBR8Z
         2hvWgeBXUbBvtsL4OC37bQ0hPO+ad/Wh1sKOV4Yx6ATYQFrEKZ+JTAZtsjteEdhzyw45
         iLb2GTJOwRVLoJtvK4Xa4zTTtNbuQqW9sVuBzg4NYY22pQDEhx71+ckaLVJqa/0k7LgM
         ysOQ==
X-Gm-Message-State: AOJu0Yz7XIhSsFSDKsMDJ+k7tmWoeThb0M2qXbCeqxdY+vZX9JAUUC1o
	5qjek63P6nep73gpKrYICFBoAQ==
X-Google-Smtp-Source: AGHT+IEf3RnQ6vghHFIDkcaI3xfo22n0ICD/Y7dXSaL4pgL+HjLTqobf8F4Ab5nqLI350QpkYuW/Ow==
X-Received: by 2002:a05:6a20:daa3:b0:14e:a1f0:a8ea with SMTP id iy35-20020a056a20daa300b0014ea1f0a8eamr792191pzb.3.1699661267932;
        Fri, 10 Nov 2023 16:07:47 -0800 (PST)
Received: from x1 ([2601:1c2:1800:f680:e564:eb78:dbd8:6618])
        by smtp.gmail.com with ESMTPSA id p47-20020a056a0026ef00b00692754580f0sm272439pfw.187.2023.11.10.16.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:07:47 -0800 (PST)
Date: Fri, 10 Nov 2023 16:07:45 -0800
From: Drew Fustini <dfustini@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZU7F0d+MCefRskPn@x1>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
 <20231109-th1520-mmc-v5-5-018bd039cf17@baylibre.com>
 <4cf3d481-c16d-4b1c-ab45-3ceff80b0b1b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf3d481-c16d-4b1c-ab45-3ceff80b0b1b@linaro.org>

On Fri, Nov 10, 2023 at 12:10:34PM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 06:41, Drew Fustini wrote:
> > Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
> > controller instance which is typically connected to the eMMC device.
> > Add mmc1 node for the second mmc controller instance which is typically
> > connected to microSD slot.
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index ff364709a6df..f5ec9326c4b8 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -134,6 +134,13 @@ uart_sclk: uart-sclk-clock {
> >  		#clock-cells = <0>;
> >  	};
> >  
> > +	sdhci_clk: sdhci-clock {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <198000000>;
> > +		clock-output-names = "sdhci_clk";
> > +		#clock-cells = <0>;
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&plic>;
> > @@ -292,6 +299,22 @@ dmac0: dma-controller@ffefc00000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		mmc0: mmc@ffe7080000 {
> > +			compatible = "thead,th1520-dwcmshc";
> > +			reg = <0xff 0xe7080000 0x0 0x10000>;
> > +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&sdhci_clk>;
> > +			clock-names = "core";
> 
> You miss disable in each mmc node.
> 
> Best regards,
> Krzysztof

Thank you for reviewing. I will add 'status = "disabled"' to each node.

Drew
> 
