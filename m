Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B023A1695
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234500; cv=none; b=lraoK/xAgvrbcayC/4bvfkYZZQuD/oL+oepLXFElb3jvkiwHkVCjqdVIgjwVH5BUCp2lhXg4/jUCZ8hvlr5Q+bdkZJ+/YEtRIqob5z/fOKDdMfZtReqMEwGaomMkNDBPcK1nPDs865PDSHIXAtsv4fHqx90TBIPQVCiJBKMViog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234500; c=relaxed/simple;
	bh=nK0DU3MeJuxGLlbEPZuVHXpO7Oe8fCVlyNAcJlYiKqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulNuo3XAp7dVy96sACn+VmDkUVC5Xk16F54Vt4l8aBIwgTfiTCHTy+jNGrSowJzEgjZJjL2gewWEBznArDO30s2JCquhX4cUMTwNDbympFPyCWHgMnw8fdeqrDL3Tk2CzZtQ6SThyCV96WTW7WTKT6J8hDG2ElZGdcuMZPKiZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlcL8UDR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlcL8UDR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-912475287a5so460027585a.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779234498; x=1779839298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwP0HqBvQS3H4GOf9mcFliGMej6PKLk/wYq89RJjKaw=;
        b=qlcL8UDRa0+iwt0ztq+lFd8JfHRh5E0T7tJ/8/MihRJjL3R0nlAz7VpiQ4lJUzhnNB
         MBCUC2f126TSfrBUMZtfJlFT34/FfhdDYRyL7Yn6EvC5aY1Y5aF5LvZR16x6m5eNbZQG
         Llc1RyRLbWkN8V2hjXGetyZ2VlIkKbWjaklOerg/wYEqBDxwDDOGon8yGfgBCzKWOzJN
         h2Fe66zXK0N3PFugg5VLPyjP5Wa4NZAerMlRJ3oRD1lnSb2A+BOSFW50CQuVwYENciJG
         nWBZQ+LsITnm6V55xC2vb/Z3WH6CW96vzqX8uyRAIF7NrPkzs81sTpWMZ/pKE9PIpFLs
         h6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234498; x=1779839298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwP0HqBvQS3H4GOf9mcFliGMej6PKLk/wYq89RJjKaw=;
        b=ULfSlId3Lvu9EpMVjfxDEvdwSobqCdPZAerYGZ2HH3nGWfcrT8894OGDfFXh7ONbB/
         Gr/HFQtRvQ/yYLlbEBzANKDqLwpmvDARDNuchCUXbtzA0GzyMYoz0C2fL7jzTuEGgT07
         Px2J6DcUpZTgmCxJ5PwLs4tl9H2TfMEJo4wv5IGqKTXDAyhhmnbm85leG0+tTDqSpYxW
         CT5RDRkGBt1YszgEvEHJE3KAnVyYJ2GBpXmE8EnKe7AUqvJYHQE3Sw81ONAgl/TJTOOL
         VA5Q2tO+gvEMvIitz0Qp41Se7WgPXncYhw6FI2vhPLhDLhQjQf8YvbRgZA8ybqcKn5aw
         yHYw==
X-Forwarded-Encrypted: i=1; AFNElJ+AIfGzo8fgKx5gKElGeZkt9FZDCFUOjgjpIC51ia5cLspaJSPsfLjBMbnDDr80sRejuUGquRJsikk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqQFNzdqOfCM7d76cUL3QnVlpQdF4DXY0KPvuRJ2MiNwEZHGx
	IhqELmgrWuxpPyHLUM+Osrr6TpZTITNpX1S5UlRcBsFVz4XzzDxq/9yv
X-Gm-Gg: Acq92OEfdxOOjhtrZ/z0M5jOBqYkWIj3MO84P9r8rbxba0+A81kE70MI+kqo/YRx66W
	DfT0DwIiReTmPouuFBQaeNkr1zesWA33Ktav06J69zajZ3ZK6ehZgqU7bE/vBMZoOS6oCJl/fLb
	TW4XzCeMCLbUjilZ0pk3yrUA7UwWUHvtkGWcrcrkp1pPWMw46E8Wn+n+zwI57VQLLVnMSTOgGXH
	LMBhjRFc6kL3LAI3axMgIbOeyHdlDRhp36CUHtPtS5eHebplQMrfr7twvQvmDVeAQU0dfil1wUf
	IlwsKdKQj3HbsvKpNQP9xvjAGDhsc3DLGeyexGCySr5wSeXocJD5yP1Z7BvAUMdwrBprMPlxGfw
	p4mxODr/P5vXFfk012Zo/zFu3VfH2pewjJOy1/er7QuFAMoT7s1znK7GbD5XUVf6ShEy1fYKdaM
	ej95qRWWKoPEnOdeMMsjgsRM21RCH6ViNnAhGV5H9XKy2CRwt/4smXQexD9xTQgba8ZjCgjBTuK
	6K3obDsLxUc7IULULeaNJ4=
X-Received: by 2002:a05:620a:a2dc:20b0:912:f763:f2b4 with SMTP id af79cd13be357-912f763f2ffmr1784376285a.11.1779234497830;
        Tue, 19 May 2026 16:48:17 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-108-17-68-229.pitbpa.fios.verizon.net. [108.17.68.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e68csm1993285485a.10.2026.05.19.16.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:17 -0700 (PDT)
Date: Tue, 19 May 2026 19:48:15 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>,
	Kamil Rakoczy <krakoczy@antmicro.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Message-ID: <agz2v0EHaffzoXxB@errol.ini.cmu.edu>
References: <20260517015323.264179-1-inochiama@gmail.com>
 <aguQwccX_ujIoARX@errol.ini.cmu.edu>
 <aguRU9Ces7ruBbRY@inochi.infowork>
 <aguWhuNsV1KKxMeQ@errol.ini.cmu.edu>
 <agvN86UYsdU7Ixun@inochi.infowork>
 <CAHp75VfruMEp++65kFtMt=Em-bF2d1jMUywT-6ropx6cTHFygw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfruMEp++65kFtMt=Em-bF2d1jMUywT-6ropx6cTHFygw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Tue, May 19, 2026 at 10:52:10AM +0300, Andy Shevchenko wrote:
> On Tue, May 19, 2026 at 5:51 AM Inochi Amaoto <inochiama@gmail.com> wrote:
> > On Mon, May 18, 2026 at 06:45:26PM -0400, Gabriel L. Somlo wrote:
> 
> ...
> 
> >         /* Update sd_clk */
> > -       if (ios->clock != host->sd_clk)
> > +       if (ios->clock != host->sd_clk) {
> >                 litex_mmc_setclk(host, ios->clock);
> > +       }
> 
> FWIW, it's a stray change.

and I'm still getting:

[    6.508084] mmc0: invalid bus width
[    6.510652] mmc0: error -22 whilst initialising SD card

when booting with this change on 64-bit litex/rocket.

Thanks,
--Gabriel
