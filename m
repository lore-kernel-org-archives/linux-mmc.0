Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CD318EF6
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129406; cv=none; b=GbhxDoU41g1hK+85SJbb/U2Ejwc9iP+U805monjkTt3AbHctaYAbWJRvGq6bs0JJbf9HS4ORUzmqhlD1bhbsHGO6TjRMC2lcNHLZctxe7+v5ZTAj9m3XPzC9Je8XRizTP4qliCKPuJzEwncH4cOVuof4Z/sgf9bOWJ6rtWfQw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129406; c=relaxed/simple;
	bh=61fxTBvmM+nEDTnrxV8wyBLBgYPiDsz7hg08HBbLwi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8yPE2rG4L2y2Uk7n0uJLHFQP3FwnJs5OzuLJSSSbClTUsF6JHi09Bkgu8043d0KwDZGPEUpwu2s9NeGPqOqXBdyhg7t/dCYZL8pQVFkKRD3xiocluSp/Kxonz/JyZo3bLr5mx1vDNklOk4JNk0mJ80qbQXVnd509y9+L6OX/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEWrLgmH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=szdmPHyL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEWrLgmH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="szdmPHyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769129397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoBRPgL92gOt6XV5p8QK+5WmhSABAsu+khI/gr5kMBo=;
	b=UEWrLgmHHcRpi51aAWBwZQW32Ki5r9cXzrC6+n0xO92Vbca3hnrziZEUOwgdpnPUbntI/a
	roend+QGV0UZ5yzWIILvUwrXRVetYIYEACXpKkVGk401RZKHs9zz24nPVOJiOkqXm8YZOU
	b4ZSr3l2spEdOvw5xz2sWukDUfz2vcI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-FADUaNjTM7mUEpc3iAQpAQ-1; Thu, 22 Jan 2026 19:49:55 -0500
X-MC-Unique: FADUaNjTM7mUEpc3iAQpAQ-1
X-Mimecast-MFC-AGG-ID: FADUaNjTM7mUEpc3iAQpAQ_1769129395
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8ba026720eeso516333185a.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 16:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769129395; x=1769734195; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoBRPgL92gOt6XV5p8QK+5WmhSABAsu+khI/gr5kMBo=;
        b=szdmPHyLXUq0kYRZ3/oR6NhVM7v/p/1dn3wFOAKID2ISmeBlGwJ+Q5GO8Snz39Suwz
         rrPDOGaFywpXkwpA95R96xF4i5A5TS35qFkbD6bpMMTLP3sq7dJlpt+hb1+vRramO4CD
         RQyyqJHpEN+7DgoVdI2xhetCQIThHaufiRwzE1YUZiZMewpjYwygi3Rsqn783T84VPt7
         RSdg1EynPNX2FZNI7ok5MUkCx0RRBn6mP1+k90f6GyYUEFw3NsUIorxHpTx+J0ec+1R7
         4NnvTTxjtfgGuYrXZWspOVkaJQxK3OjabSMv4tC6QFBSJB6UyVXR/aYb1jNGc40ro9xj
         JkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769129395; x=1769734195;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GoBRPgL92gOt6XV5p8QK+5WmhSABAsu+khI/gr5kMBo=;
        b=J8D9bFZqEvmETFaZY5KPj3nPtwRBokKrHF69ZxUvYxhR0F6KegFmvbaXbzf27q/m2j
         V+aW6JkkUl+FR+vm3gHSwaP5LGyTbzeCThMDq7/m4HfNF9aaq2hQvwxdiVhDlmq9QGk2
         bHDlTuCN1QNPk+EeYnVNsbSDXqsfdel2o2B9UuuuU1ANpXq1IRLeY454MPmVuG7FK+BD
         gSLwU/pPBihD4yRQduRSpRCnZhGF0ME31zGhQoVgBvdDLx1aaPajVOrXDFB14D460X1Y
         HCgvdUF/0o6e7H2SW03cZthFFHYOpi+/zMG8JiFk6q3boLYdt1GiIX67YWJdZWSnmT2u
         AgOA==
X-Forwarded-Encrypted: i=1; AJvYcCUNlTOdHPuD9iAS3GGa752F968x7qKm52YFdu+VP41QIKl89BsoCsB7rxZ/muFnDiPkydK9ApugEsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mlWjT1ZiOorB+m6uGq0R/60iQiMjDZ9fd7er1NNgRpKvftik
	AbyOtLsw+baEU9e1Qm16DwW9keycc7+V3SinN6246t08Uo5V7o7jUXGAQTJ2+6fw5M8DL1alJDN
	C7Pr6oX380AGIgZaVPyjJAQ4zVBSH01nqOyMPvUQ6r5SJIw66uDOd/GyYKyooxA==
X-Gm-Gg: AZuq6aImDZL6dubrRD2DrC3KiTv8x+ZEMfA5SWklW1ZIcfOUqYLY7W4mDQNeE7e7gBp
	JYZAXbm6d5Ops7XJPZBCID6XadX9ET1COJ2Jy3geXdO1sFmGcxqv9JRPGGRmYJ6VPYwBxDxpDE3
	SPzSFxrhBYR5kGRExFFy0V9MJnFv6UBxXVyDDauj2kPE19CXD8JKf1kVrqQVdUe+eoZ3PWLxdvg
	HK4LopM7mAxzsf9AQDYWLrYpYx8ikBosgd4RDekLgfBZJO1osFsirgi77DDCAoYmuRH3ihdfybe
	zh0f5lNR/+U3W3ZIJlYD/a9IMCG80alyqRy/FmXdkukEPO9rnAEtdwdFNMrO5F7y4ZEIHuZpdye
	S38FA7US82fjKys5/+G7Y0xCZeezDS7MrHllYUVxfkcH5
X-Received: by 2002:a05:620a:298e:b0:8c5:2bcc:fbc2 with SMTP id af79cd13be357-8c6e2e4bf45mr189823485a.81.1769129395205;
        Thu, 22 Jan 2026 16:49:55 -0800 (PST)
X-Received: by 2002:a05:620a:298e:b0:8c5:2bcc:fbc2 with SMTP id af79cd13be357-8c6e2e4bf45mr189821085a.81.1769129394805;
        Thu, 22 Jan 2026 16:49:54 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e383c2bfsm54737785a.29.2026.01.22.16.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:49:54 -0800 (PST)
Date: Thu, 22 Jan 2026 19:49:52 -0500
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
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 00/16] MIPS: move pic32.h header file from asm to
 platform_data
Message-ID: <aXLFsA_bEkXLr33P@redhat.com>
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

I'm just checking if you'll be able to take patches 1-15 this
development cycle before the merge window opens?

If this series goes to Linus during this upcoming merge window, then
I have 17 patches ready to post in a month for the next development
cycle that can go to various individual subsystems that allows all
of these pic32 MIPS drivers to be compiled on all architectures. The
patches also fix some issues in those drivers that were found by
kernel CI.

This merge strategy makes it so that we won't have to deal with any
cross tree merge issues, or immutable branches.

Thanks,

Brian

