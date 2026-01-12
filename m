Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086D33E377
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251278; cv=none; b=CT4L/zVSjkH7yyAqR9V+FP/jB4m+CsRd95wdm/hvnDAB/Go/m1wO4U7mgHGJ2AJ8GCdIfsjRk+1SIFBxRxfsq/TWtnP5Nhb2dfhftg7X8XVylsZFHtBV0qXJBwTYr5MFS9fJv8wMWdGSk/t0cyMFoCXbYBQ5qgFZwSn5fOZ7opg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251278; c=relaxed/simple;
	bh=heWjzF+AmilmUzHwXu1Ept7hAquo1V8G0vGWDv2VRkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNcuOZqHubL78Son8vXO1lvhyiB7nyKf5Iv42ujTVjYQ4e9Wa+w6ZOHmAfkx3U2Po6ghBf6bjjbI6ID/gcFtG7rbL+8nXEjSu0ZjxQGkaJo4NtFAs5rpYAcizB5YYpOGPFCWwrrL8DerBSnpiNTMkmaqLHqmeecLnImzp9PLGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBBrTg4q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNRcrFQJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBBrTg4q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNRcrFQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768251274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RQtLUY/JE7t2au1QRWYYIx7qIRDxSfraBeIEwjxysb0=;
	b=EBBrTg4qNBDVgAH/2+iqjTfPMqOUExtbza/uusae7sPlUWdu4YrMRxZQuvBIk8Md2o1DK7
	L0d8sq8XdunaB/7janAaQx75Ehsd1sCmMODnRtAtD/yvSEs7EtuCszxBKtrb5dOICAQXiz
	rY2GNJeMG2R7/QwqoapXVRALMBRvJX0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-sg1fxRAlM3uapSZWBEMkfQ-1; Mon, 12 Jan 2026 15:54:30 -0500
X-MC-Unique: sg1fxRAlM3uapSZWBEMkfQ-1
X-Mimecast-MFC-AGG-ID: sg1fxRAlM3uapSZWBEMkfQ_1768251270
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-945f0b30b07so5604668241.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 12:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768251270; x=1768856070; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQtLUY/JE7t2au1QRWYYIx7qIRDxSfraBeIEwjxysb0=;
        b=MNRcrFQJ67bj31HEdT9YeC9SXvV8aoX3ihVzJmfu9SvRrvCxUnrBosy05zB3PvWExw
         8LMwxpPHM4jjbKnqcNhWMMk/G/sFVPDzDVfsp5ZpOKwKwKrkRT9kCKZg528NWoT506Pj
         BSjNseaDV6xe5ujzxnVQV+It1rp7w8cVErl8qbMOdlnWdek0iiPLTkeUMAMbRzcfxy21
         KlCO4UTknZEAbkuKRJeAc6CrcI+SUFcq8OlsHIIXP5ZzjO8oQzx85B7o8YX/u4pLcz36
         WSj4IkI2HGhtVE/l2+IvMTYe5W0p5NZgwxW5FlGieqnXUP49ZXOm3djM3s35FBruxqKQ
         Y3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768251270; x=1768856070;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQtLUY/JE7t2au1QRWYYIx7qIRDxSfraBeIEwjxysb0=;
        b=XaUCz7KXibGkZXqXJo/nCgXXvLxk12zSmLe36+Y/eCVnrdDOy+Sv5LHiOhWzksTeqv
         bykb3EU2nzQD4PGt62nxjMOWPAovIpNxjQKe5N92ccS8uJaQIzhwrOhml16wv/pt1wvq
         CH5qs7fAaaEDJbZwLwkEPrdQwOxniNUSFscHD4lC6aoAuS0PkN6IDWXCNsbtiMhPj5pD
         pJUcaoJLzZ/AgBMs4UKSd+iBjAo4adF/CknuxSbw4F33bbzA18xXCsWuwZnMg9eBKTG/
         tycrLQqWashRrHMNgKceOueh7FhHQ5wnCQSLC/bmgJAtdsgsn9PEY5TwWxr8q9e1Dq80
         a+eA==
X-Forwarded-Encrypted: i=1; AJvYcCXy25hqvwQAwtUo8l1bg5JzRyCcmYrt46JEStXJX79Z/zFr7ZmvKI95PubxKwrc9LIsfdgvSkzGiJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvFHKjP1kAhiuXaB1kClrpX8mDcqkvIjrmRreA4RsXf1ARWk5
	732ZaYu55sATXVb8zgUWbrRYpKbFa2zVRIwIjqCc4q6VLZZjt/SuM7Xdl4YS/dyp+8m6wDPXtMw
	hyYfap+tcAx6I4GwBTVJPCsJj5Dkktm0fv+ZiowcHPQv1BJ8uyLi5efk1D/cGxQ==
X-Gm-Gg: AY/fxX40xw6KWmTfC3JCNupvjVvljchRHWR7TgfavS3LEfdxGu0GLhZ68M77jKHP1iN
	+Qb47POCgi8ILpoQe8rR4C2xaUzRjrJdc7Gx9ztpUbYjUNRG77hzofvKJOoaPb4OBIFtI0rufOL
	xLGE8pXREfvEUsU75cMxeBnNdVPFutVazXdnd2kwpYXVEZIVC5WbNWAVba3SXiw90OxfI7Lx5xZ
	kXPHlPWhiNGPihYuufK+zjUcF/a/Zk6QzPTjMl2ca8zmazlND8Dvludidm+K9VwOzcKl3jpJxr/
	0qGwwvbX8uWLnFquV9qCiurPlDoN8P/X8CpUtJH1kMmU3+jt3FITZVsbkhkNx4cY2kCfqG7njnV
	32lOnw5gL
X-Received: by 2002:a05:6102:f0b:b0:5db:ecac:5800 with SMTP id ada2fe7eead31-5f16cacb7b5mr354897137.19.1768251270179;
        Mon, 12 Jan 2026 12:54:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUy4CpEwuxm8S3FrkZ8Tlt99aDpzL3BC+8t5fBT66xtDR5qpVls7IxrVD5mbftlUkdr9xx2A==
X-Received: by 2002:a05:6102:f0b:b0:5db:ecac:5800 with SMTP id ada2fe7eead31-5f16cacb7b5mr354883137.19.1768251269697;
        Mon, 12 Jan 2026 12:54:29 -0800 (PST)
Received: from redhat.com ([2600:382:771e:5aa5:103f:e4ff:d734:7cd4])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ef15be79c6sm11394917137.12.2026.01.12.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:54:29 -0800 (PST)
Date: Mon, 12 Jan 2026 15:54:20 -0500
From: Brian Masney <bmasney@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 06/13] mmc: sdhci-pic32: update include to use pic32.h
 from platform_data
Message-ID: <aWVffIGEtPYZmdkh@redhat.com>
References: <20260109-mips-pic32-header-move-v1-0-99859c55783d@redhat.com>
 <20260109-mips-pic32-header-move-v1-6-99859c55783d@redhat.com>
 <eb84ecc7-e409-4e2e-b609-7fe68336feff@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb84ecc7-e409-4e2e-b609-7fe68336feff@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Adrian,

On Mon, Jan 12, 2026 at 10:40:03AM +0200, Adrian Hunter wrote:
> On 09/01/2026 18:41, Brian Masney wrote:
> > Use the linux/platform_data/pic32.h include instead of
> > asm/mach-pic32/pic32.h so that the asm variant can be dropped. This
> > is in preparation for allowing some drivers to be compiled on other
> > architectures with COMPILE_TEST enabled.
> > 
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> 
> Seemed to compile on x86 with COMPILE_TEST, so please also add
> COMPILE_TEST for sdhci-pic32.

I can do that in a later series once this series that moves the header
file and updates the includes lands in Linus' tree. These are low
priority fixes, and I don't want to create extra work for the various
subsystem maintainers with all of these cross tree merges, and
immutable branches.

If patches across the tree get merged in the wrong order, then Linus
will get some build warnings, and I'd really like to avoid that. :)

I'm sending out a v2 of this series in a few hours. Hopefully the MIPS
maintainers can merge this for v6.20 / v7.0, and in about a month, I'll
post patches to various subsystems that enable COMPILE_TEST for these
pic32 drivers. Based on the clk driver, there's likely to be other
cleanup pathces that will be required as well, such as to fix sparse
errors that will be newly introduced since the drivers will appear as
"new".

Brian

