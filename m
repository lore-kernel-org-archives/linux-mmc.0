Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA0F4FA
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727353; cv=none; b=PNqzsK4ZgE3VuUpnic/MA5v6uW+u2Ns9vHOR0ONWuNn6/bM7SYxMGoPItspf3wbCzgTXbkekgzJ9+shHSne/T3vn+V5W0DrLchnIml/0MbNFP8b3a3hxG+9c6d++lCEKthSserFVQBiPfluzOoIzgwt1yyFPJ0bYA1ePCM3oUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727353; c=relaxed/simple;
	bh=GlKpwAqt8FXcLxnYzpl9cDfIBN0bnkDbFsP/hLk3P+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlvt7oJsn5sOvhqyIJv4c6r1N3WMQgsm01HfF5fUwUoqjT9zUaoH8M7IxCdl5tIbB9YsIdjASR+kPwJTgLnRhwWn5QwUSctzJgM7sg0IxMwmqtRjime/rY8VCNu7367n8ipqG5311G8P0glOm1nHp9Cc4Yxg+GkSXcG6Ofk6c3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJxAFGAy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFZWnSsK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJxAFGAy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFZWnSsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770727350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WIPR0mr/henT5bqfT/DKonkyulUdL16MgQRnA6kCJNo=;
	b=QJxAFGAyIKmrh2zuPDOEVxHSSsQ+Jf7L+htFf5vMa5tb/Cu2euhDMn8dx+Byo8R8Hudl9M
	BpdK0u2HUQIRXeSHGclPm1/WNzXqAF5OCPAl4MHZCloX5odBLEeYrwFTZ/DjeyfEedxfHK
	MqvZw5fHRmFufbcnVBE5rEz3/axQbn4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-xTqKWuoaN_iUgdJs1DM9ug-1; Tue, 10 Feb 2026 07:42:29 -0500
X-MC-Unique: xTqKWuoaN_iUgdJs1DM9ug-1
X-Mimecast-MFC-AGG-ID: xTqKWuoaN_iUgdJs1DM9ug_1770727349
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8947d47793fso257694846d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 04:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770727349; x=1771332149; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIPR0mr/henT5bqfT/DKonkyulUdL16MgQRnA6kCJNo=;
        b=IFZWnSsKBQErk8CB8YJCIzGXGKhz4eZMSqPEtLSbj/uwH1A49Xj8LoEJhF6pcy7d2N
         wlrMn9/Sn1Mo4z1rC+00Go3UA6lbA3d6Hv4jolfseNvy6ah3yscypptRH74J9Ncsk6t1
         xD3mQC4Rnp8JTe0NG29vD8wdEU8kt24v6HpCcHydeRNMA6gp8lsgxaOr6upY/soKLji+
         WQtuTUoh3cqzEHwDKL5M2UpPRLACMunCmNF26lRd+oRTofcRF95ITIIln15DqswXvFOc
         rMsxu5C/5vi4M81xOYakJto56DcPPVPy8OmgVfkHCHCdcIFUSLgn67uLW3Z7ftTpq6R+
         6NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770727349; x=1771332149;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WIPR0mr/henT5bqfT/DKonkyulUdL16MgQRnA6kCJNo=;
        b=hwiM/MjGaXmbx57S4TmWzAfE2jTUzwbljEjwGGqjk1AElHPjj5SN5qbwgcXZ/d3Dlg
         T4JINIyLKyyebCX98tvWK2+voiR6cmQ7M/BYjjtyh8gd1NIjRFPz5AzIta0nGVwGRvXA
         e//1Rn/9FlqhwjibCLaQIJCBE0wKXSSGExN+V6T8o8ClPm7MBVwjKUmSPHXMRdwAcu93
         7+Y174ko7Q5idRSBtid9gZAfcyXWvOaceEfwMicJvR1oNZ+8SezqdOqoVvYHWUltzZ61
         tSjc1nS/l7EX0oxA70kqpOQaDFSKgkM6xA13lyznUK1uy2o1eAyQHCKkmSnJ7KyEakJM
         9+rw==
X-Forwarded-Encrypted: i=1; AJvYcCXH81wTdPKgtFXdVQZG0+N9o9xdZprTdxif0C79OpiU72AlezkT6ugBTqmG2kLTo5Pli4oBcb7UULg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zYn0crCPTlwCh9S9pHfrce08iz1KHljYbJ/x2rd5Ef3QmYG2
	X/igkvT+wykCLTQxADwEuALaJUmVL3MpmPNIn5vTOXJ7jSj7A620uo1aCPrNn5S4aKCiIigtgqb
	iU0JLYOBTPaYyW4zVKP6N5XWyra4NeVHbnmAIygF5LQwEjUevKUtLs4nrhMinFg==
X-Gm-Gg: AZuq6aIfa4DIJ90v9MbDJD6KYZ6FDelMZumdYjE1Gbb9RZpBMOWYaekjF8VX6wRq36a
	qE7SZK2PCzOXyl9YhVD2dBeZAzUZEfzM7L0KYAn9yWzO201ZoFlxyr9SLwOMxToryWvN4mv/UvK
	AHO56C1TnyL2YegTM8RNEwVcje65G/pnXQKL/tpAW/rhNZ2K3etHKA1n++4AxneLQ2jfvB4YPGX
	3AA+KlpUUZbF3j+o78kaCJemUndH1H44AOCEeCnXOJyV8khwk8RMwcI1OHtGw9OCv9qCi1fSgY+
	w1aXWTZk2khIuE99GWyM2eJRTmkhtMgEY/f8ses9H8Of5WKC8V5twTkZ9yHh217tPi7R2vBRZxM
	3IRM8LrEDPq5x8CINjc8pNlFx8mRYxn5KDE3drI470R08WIVFw4LRbKf9
X-Received: by 2002:a0c:f952:0:b0:895:4cc2:8bfe with SMTP id 6a1803df08f44-8954cc28dc4mr97314076d6.48.1770727348935;
        Tue, 10 Feb 2026 04:42:28 -0800 (PST)
X-Received: by 2002:a0c:f952:0:b0:895:4cc2:8bfe with SMTP id 6a1803df08f44-8954cc28dc4mr97313856d6.48.1770727348578;
        Tue, 10 Feb 2026 04:42:28 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c0599b4sm99582176d6.41.2026.02.10.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:42:27 -0800 (PST)
Date: Tue, 10 Feb 2026 07:42:25 -0500
From: Brian Masney <bmasney@redhat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH v2 00/16] MIPS: move pic32.h header file from asm to
 platform_data
Message-ID: <aYsnsecPa8bWMbaA@redhat.com>
References: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Thomas,

On Mon, Jan 12, 2026 at 05:47:54PM -0500, Brian Masney wrote:
> There are currently some pic32 MIPS drivers that are in tree, and are
> only configured to be compiled on the MIPS pic32 platform. There's a
> risk of breaking some of these drivers when migrating drivers away from
> legacy APIs. It happened to me with a pic32 clk driver.
> 
> Let's go ahead and move the pic32.h from the asm to the platform_data
> include directory in the tree. This will make it easier, and cleaner to
> enable COMPILE_TEST for some of these pic32 drivers. To do this requires
> updating some includes, which I do at the beginning of this series.
> 
> This series was compile tested on a centos-stream-10 arm64 host in two
> different configurations:
> 
> - native arm64 build with COMPILE_TEST (via make allmodconfig)
> - MIPS cross compile on arm64 with:
>       ARCH=mips CROSS_COMPILE=mips64-linux-gnu- make pic32mzda_defconfig
> 
> Note that there is a separate MIPS compile error in linux-next, and I
> reported it at https://lore.kernel.org/all/aWVs2gVB418WiMVa@redhat.com/
> 
> I included a patch at the end that shows enabling COMPILE_TEST for a
> pic32 clk driver.
> 
> Merge Strategy
> ==============
> - Patches 1-15 can go through the MIPS tree.
> - Patch 16 I can repost to Claudiu after patches 1-15 are in Linus's
>   tree after the next merge window. There is a separate patch set that
>   fixes a compiler error I unintentionally introduced via the clk tree.
>   https://lore.kernel.org/linux-clk/CABx5tq+eOocJ41X-GSgkGy6S+s+Am1yCS099wqP695NtwALTmg@mail.gmail.com/T/

Sorry about the duplicate message. I just wanted to reply to the series
with MIPS in the header so this message isn't lost.

Can you back out these two patches from your tree in linux-next, and not
send these to Linus?

clk: microchip: core: allow driver to be compiled with COMPILE_TEST
https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=026d70dcfe5de1543bb8edb8e50d22dc16863e6b

clk: microchip: fix typo in reference to a config option
https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=a6ab150deb4b740334721d18e02ad400a9d888f5

See
https://lore.kernel.org/oe-kbuild-all/202602100954.BAVYq6aC-lkp@intel.com/

All of the other patches with the include changes are good. I have
patches queued to send out in two weeks to other subsystems once the
include changes land in Linus's tree.

Thanks,

Brian

