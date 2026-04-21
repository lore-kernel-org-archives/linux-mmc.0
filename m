Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77D3AD52E
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764397; cv=none; b=X0oQLxE9V5+Gfmp2uw1RWh6otOXzXTOluJW7qn1Qu5ZnVt8ZyNMC50VhP7Y4A80GsDz9uPZ4V0rftME5YJdWNO7kFlCVHMiwicLzNGx+vaAFFEOtlwb5I+zynjkLcXQb/Yp1fyXK8RonTUclhcNzomIT3vcnlMkx7EkI5wtJLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764397; c=relaxed/simple;
	bh=Cx5lNyTQK1K6867Mq0oTRD3K/G0v7xcdF4yY5xGZDPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrNSlAISdYKnzu8VaMKjVHkay4H4G3d7g+lPCgRDCdTBjKw0XsdDw4ZLHU58lUSQM7OBnIF96W1sMDJ6gXplGUP9S39mrxcmgVzkOwDOVZfFqmL0von/YbEkmKcmEO/T0hz4EVyrwQs8qIPZ8QITyEKB0RtvSawhw247b+KEuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS3N6t5/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS3N6t5/"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2369481a91.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776764395; x=1777369195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GZzQwKe59DGjHwaaHi+Tkq+lXWWwyROkz0lQU7s5dlc=;
        b=BS3N6t5/PlWkd76PczWgilYp4fpir9O/8NvSEb2f1BNzef0PxTK08invt7OD2Scl99
         DNmqjiTclIfzZta6cn8gAZJGVv+M/62qpvjAXlCXoVKzOlJjaQ+atPtbkoUwdrloi0lA
         uLEWr8kiFUA/+YOj033faOeTifPQ2C/AetA9y+m70yzHyr5ZFCRFHNi82dc3WVvJkWqq
         57AcWYC1/uKh8NSZnXZhzHk2YiDz01Zi6vzxREClzsF+zkhISHeGhkq6oNsTcfExlY+M
         6ch8CAhWcUzUddq1K6i5GDex+VbW+BS7+d3rzlrapep66TZ2l1eof4lqh9iQHYm/PL/H
         nGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776764395; x=1777369195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZzQwKe59DGjHwaaHi+Tkq+lXWWwyROkz0lQU7s5dlc=;
        b=P64FvQQUDGE7ukw9PwG9r0ebmc2Mup+UHiGWj/M/jBDOkTB8oJgpzKBWliHbwWE4O6
         zCSU5O3pawG1VYqBPbQePD46G5XlyHIgB/RMEkDtuqRUVXUB/V2BEhuYd6UsqQjAE6GV
         Jp5LAwG81hLNTCNaSHV1GC1K62rgi2/SXj5n1MpZUNEUvUzjeezaYD68/WrXzLJWXg84
         Il72V/0+KgRXsp3nO5gswMMDWNRagpRZNyPrB8CdhA1wnQKo+A/9Raf7viPtBGdk07wY
         83TbTWc7k65mjAXkODfSymZRWjylw8Pn5oXwOnn2APWcqjM0P+RQaU8eBJ5DCvCabNUm
         RBDw==
X-Forwarded-Encrypted: i=1; AFNElJ8VHej6NG1Efj2i0XQND4HaMVFNhiXSBKPMI83TAG9IVaEFBrz2raY6pvXUDbSdkSvwmWnfpYiUdIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLF4qkYB+QOEvXRLIMeY5gchsfAGxIstVqpSTbW0XjSbV8MCun
	yUfU+1UWZG3+nbdZaNeAVEjcGRiLY7auj8WiAKRnlw4mzc6vBoDzGFMd
X-Gm-Gg: AeBDievNscwk+LyKZiV9lGULDEPriSxz9DWJyoEhWkb9XYQt3w4zMNUcq/J30HfW6kq
	j34b45I2/O727r03pKRZ1Qn1vFDut+fnkOtnzi2cgBbZuVfUoT40uUP+jeDY5qpoPjb8un/0e4X
	DM/1SuEPafuTMTif0F7OlHEg9W+Ng4qDXKDCGozlPfelNQGpXxYCLBLf25whF/WZgLyHIu6chhf
	Dqyi7FR9t9V+RcYV/Vsu+3G0mrzUuozwi/DIdFcvEtzCZI/hb1JrwKwREgUkP0PS1NqoQNu/Bl+
	gSLelNA/2RKx3M3K2az3TZQFRLOkfHzhXAhwMZWFDTZbh4wPPgof1/nO6Ykxqf0+7WtYVyUHR9U
	xPzxm5apoMD3tenmlalgXBu00WtJG1rdM+gs/yctbiUdMqFNhcYyYNgqWdODlPj8MXg+GrOSlMA
	nWThMpFGIxRR2yuUc8wpKCDiNflzP/VvJT+Q==
X-Received: by 2002:a05:6a21:ad1a:b0:3a2:dd8a:5088 with SMTP id adf61e73a8af0-3a2dd8a5c92mr3788398637.51.1776764394613;
        Tue, 21 Apr 2026 02:39:54 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703ddf8sm9983635a12.28.2026.04.21.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:39:54 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:39:38 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, 
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>, 
	Maciej Dudek <mdudek@internships.antmicro.com>, Kamil Rakoczy <krakoczy@antmicro.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <aedFmiR28hohdtZq@inochi.infowork>
References: <20260421025052.755471-1-inochiama@gmail.com>
 <CAHp75Vf8DN-FY=DKrcid5rPk-tM6o4mxyPLuYGEsNUqrksEdPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf8DN-FY=DKrcid5rPk-tM6o4mxyPLuYGEsNUqrksEdPw@mail.gmail.com>

On Tue, Apr 21, 2026 at 12:01:57PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 21, 2026 at 5:51 AM Inochi Amaoto <inochiama@gmail.com> wrote:
> >
> > The litex_mmc driver assumes the card is already probed in the BIOS
> > and skip the phy initialization. This will cause the command fail
> > like the following when the old card is unplugged and then insert
> > a new card:
> >
> > [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> > [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> >
> > Add required clock settings and initialization for the CMD 0, so it can
> > probe the new card.
> 
> ...
> 
> > static int litex_mmc_send_cmd(struct litex_mmc_host *host,
> 
> >         int ret;
> >         u8 evt;
> >
> > +       if (cmd == MMC_GO_IDLE_STATE) {
> > +               litex_mmc_setclk(host, SD_INIT_CLK_HZ);
> > +               litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> 
> > +               udelay(SD_INIT_DELAY_US);
> 
> Why is it atomic? I see no evidence this function requires an atomic
> context. Please, use fsleep().
> 


Thank, it is my mistake. This function does not require atomic context.
I will fix it in the v2.

Regards,
Inochi
