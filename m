Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2C433AB
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nUfT2tgM"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D545E5
	for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 08:03:40 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7789577b53fso426839085a.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2023 08:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700064219; x=1700669019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tDYXry5Yt4gE435+5gScTv9ABMQHbckYhe3lM02emE=;
        b=nUfT2tgMZteQ4oDEiu+lc8tSNFEpeM4gJrzawA3AQw7h67Dpb6tLhqxXPoKJlp0ilo
         F2UyEFvItcuvwRKAr4TPXjNut9YzL1f/2NmhF6MKJw/LlNrA3djGtCfMec4uneeJ4vz4
         hn0cLXu7VpuWvwZJhFHJ9AHJUHaHJQ9d9pZtPslzkHT2LZj911hkldcJrlvptQER0UHv
         GdG3wWKrdlTTuDakaYInnsSmK8f8DYVPhGQKNQMgTsQfGDykktL8FAFmFu1ar3UybwRf
         1ekFA0uhZHSmFnIzuJQVgtKAmGS59dVIFA4YVGYk71hiyGJJ7sXHNkVLtP8v7ymPYOcV
         A4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064219; x=1700669019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tDYXry5Yt4gE435+5gScTv9ABMQHbckYhe3lM02emE=;
        b=qc0okubtVId6jTm80wClDNyeeVxLlt1AMUxz8SZVC01XgbI5Qejft9Ah9RNg0sZxHo
         G/NoCPGAHLmJxoT0XDjvsmGDnc8YM+o573ZHyLaRb9gblhTl53rKL38sRzpGeTJdRPki
         bP8Qn5yVDsqJOC+SD8EFWubNptF+AZ/ZsMpg/ZRJuXkBiOpMHF6SXbAZq0AdnKzzMpDH
         xoGaPxnvSMXnOQ5WNMORcFlmEPqBXKt1aItKVWlk/cgJG3JVQr84HpsFbfAH5OO13wwW
         J/Wk1boCqF6fIN/CTR4EdTnP3fP8FLtK3tyTWGP+YvT4qNroIZ70zGC4sX3o/RJiZNth
         l3Xw==
X-Gm-Message-State: AOJu0YzfWHR8LiHXnoaK8GhgmdXJ6ksD98n6qzueGClJ4F9IUD4fgjgj
	OXQ2WrLR7JmjUv4jIA/O9uJaoQ==
X-Google-Smtp-Source: AGHT+IF93JhWNlbYNdOEZtUE6mCjhq9mjRfXWGgqHnPrwHynLnLGWfpW+HW6XqPiTsquRivLQ2yAuw==
X-Received: by 2002:a05:620a:3aca:b0:77a:35f:61fc with SMTP id ss10-20020a05620a3aca00b0077a035f61fcmr4931758qkn.24.1700064219254;
        Wed, 15 Nov 2023 08:03:39 -0800 (PST)
Received: from x1 ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id f5-20020ac84985000000b0041815bcea29sm3614057qtq.19.2023.11.15.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:03:38 -0800 (PST)
Date: Wed, 15 Nov 2023 11:03:37 -0500
From: Drew Fustini <dfustini@baylibre.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <ZVTr2VaZPvE45zP1@x1>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
 <20231114-starring-swarm-0e1b641f888c@squawk>
 <ZVP1AoosripWj3gs@x1>
 <ZVTiFVHSsBxk3pLH@xhacker>
 <ZVTi3lvSQEXeTbUN@xhacker>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTi3lvSQEXeTbUN@xhacker>

On Wed, Nov 15, 2023 at 11:25:18PM +0800, Jisheng Zhang wrote:
> On Wed, Nov 15, 2023 at 11:22:03PM +0800, Jisheng Zhang wrote:
> > On Tue, Nov 14, 2023 at 05:30:26PM -0500, Drew Fustini wrote:
> > > On Tue, Nov 14, 2023 at 09:27:44PM +0000, Conor Dooley wrote:
> > > > On Tue, Nov 14, 2023 at 04:07:59PM -0500, Drew Fustini wrote:
> > > > 
> > > > > +	sdhci_clk: sdhci-clock {
> > > > > +		compatible = "fixed-clock";
> > > > > +		clock-frequency = <198000000>;
> > > > > +		clock-output-names = "sdhci_clk";
> > > > > +		#clock-cells = <0>;
> > > > > +	};
> > > > 
> > > > If only you had a clock driver to provide these...
> > > > 
> > > > Is someone working on a resubmission of the clock driver?
> > > 
> > > Yangtao Li posted an initial revision back [1] in May but I don't think
> > > there has been any follow up. It is for sure something we need to have
> > > in mainline so I'll take a look at getting that effort going again.
> > 
> > Hi Drew,
> > 
> > Based on Yangtao's version, I cooked an updated version in last
> > development window but still can't complete it and met some issues
> > which need the clk/pll register document.
> > IIRC, the document was released a few days ago before soc tree frozen.
> > 
> > It's nice if you can continue the effort! I'll read the sdhci driver
> > soon.
> 
> PS: I can send my updated version to you for reference tomorrow.

Thank you, that would be great!

Drew
