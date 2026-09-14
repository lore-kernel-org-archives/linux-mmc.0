Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B646D090;
	Mon, 14 Sep 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389088; cv=none; b=iUtmii6odj806tU9tnm4fw70uDcId2ySlVBXfBBvdPXoc14RnxnM9/x9LeVbZOZu9PgdePqPw4fNpFTk9X+fQWkZDSPX/LImyLQ3+AQFzQlqj5mNwQsrJd+mtChR+p8nJETmjHMmTWBgTpOCMRp8PHNvefXpSzBvhsDwjYESrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389088; c=relaxed/simple;
	bh=l+PGbuM+EARA3jWvF2nroh1J0kc1Wk9vDqvYdLl/daE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jRqXE+gIi0KJn2JJCgkeS+/sj0FDruoYMdiwmV8CBg7mY0eqcbztD2q5xJvCJpTUUApbSqX7Va8Y0iJqlrSWDnvOe9a1Aa0zccQ7TA2Z2Ut7W/5B+QXPCPBfLp8r1rYr1DHOBZCuOVNeVyPMBZbcEjRhT4HOHQXZwoTs/r7B09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QkEOuYwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tSjDcTHv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QkEOuYwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tSjDcTHv"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BF3D1D000B2;
	Mon, 14 Sep 2026 08:31:19 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 14 Sep 2026 08:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789389078;
	 x=1789475478; bh=7qQyh/1nU4neVp7GMM4tVs9YrI6Qv+f2RffqNUtcZb8=; b=
	QkEOuYwUwYVwHwi2VE7Ehojfbm68RNJuBD+Qdn3rRg3f75LAFpQoce1bOVKr2RHZ
	pNR7kxssdLaIvI6XE7e7t1K9AtnMp3TS0On709jyL5sitMfAnRSoFZMiaz5gQoU2
	RQRNNoS+Njt7S6WiSF0W2vl7YBrE8WxHlC67HhTikBjAWRgWAOEUBny+OWft4H0I
	jPHtTghcem5kcuw4qK7iIafxY3YaUw8SrOfdkEHj7YtB9e9CQR4PApmeW6/K7eSD
	KaEapd695Nv8kZGKGlFK9LxEY9BVJ06Ud2juwx2JRCzzv6NG1zZiDNFc5H9DT0R7
	lVtM6EW3upZY5besWqCEwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789389078; x=
	1789475478; bh=7qQyh/1nU4neVp7GMM4tVs9YrI6Qv+f2RffqNUtcZb8=; b=t
	SjDcTHvXulYdr2cqT2ECuzIRynWzAwRr45tObdKUGtIzKRV3jq9dhzPfIiMGupgu
	hBJKA4nxxSYmg5PFjZi5inqweBc7PpFdLBG2Tz7JDRzVbiS9gZmPeYQTnRPwxnD0
	SVnOLwUA5z1OK+yCe70zJCNCe42PMyZELVpaXFsfiGDPipb41TgsKrzEtNWY7tii
	R7fBMsSvx/x8YZmeqFb9+kB83efSGEbRXVmWzjpOb+rYpWGeqUPyaJkBK4nN+wU+
	Iv7R3IUMp7wUvmhCj+XQ85Lnu8iXI4tu5YtflShtyJa712naLYQZIahT+Uir63UA
	kJUtJUYOHeFc/AIZEj0ag==
X-ME-Sender: <xms:E-mnaob3Qs3H7IH6_2Kjwe-ImYYPf0QRrysjTAQAtCI-T7iIfwTuuQ>
    <xme:E-mnauOb_M51wKfp2VZE4oARtougUkdgXQuXJH7iYBuedhSpPT_acUdflRFdwZ4GR
    ch8YprzqDSybkRLPC-HM_rwrCezv3KRGIE4ht5H1977VcflGkk6G8nN>
X-ME-Proxy-Cause: dmFkZTEyRZS+dxtATWaGW0xXIXF9yvp//1Mbfr5zC55op0riv6jW9afUj7B2uBZAy2VBfs
    Tug6oGk8uojS3fhwLKeR7VFHaoh9EhaHqrgBq2sLeE0x5QwtHxy333SoMbb8IdN2NW+pB4
    12PoAZwxbUW+V5n9J5P1gsVmM9Q74t0j2F5/qWdsNhoauZGrymXHPPAveIEe11bu8yDl3y
    2pEYU7BPdCG2zGEikZltESCQMupnEBgZyLRmh/2OyWv94KmMBjig7Kn0WureEC9lT2ve1m
    tN2lPvYSSeRXUBFsqM8k5FtCcZRTFuujFA/9ul2La/nfIuqnwNTCMz1uWCkfotatWoJ2Pi
    N5pYAl//2BY2zNIusZnWkxIY92ljmeZvBmvuUzMjCvlukoUFTfiEBLZPZFpVvbLID+DlcU
    ZWaDY6R9NhlzIzpk0zqljJXPac8ztcD2OBlO9Kwo5vQIdeKpd0sPzDFzvUWX0jYmb/FN3Z
    cb5am2vSBw4qx2X8sGcfbHr4TkgWpvnCIC+woYNcALsH7wFgJkdP8hLfT5EXJVhIuRNfUR
    /SA/Rq9LDKCaClFnc7xFDdH/E7fLKahjigCKff7pCXqWGa5v1WeI10xpV2ZuljHmQzNyON
    2UMyXwMpjCqGHqaXlCJO9G4OOnKvKBr30+j8JEH+cOAbXArKKb3zLy8fBtaw
X-ME-Proxy: <xmx:FOmnai9cXIdqgktzLz7tb8LexG3ZRoN6BuTxag04BE_Xcq4n5Ov5_A>
    <xmx:FOmnak9-R1kNX1JEoA0du931WxiO2Msc-PPRzOj5f1YNhO-1b8sgRA>
    <xmx:FOmnaqSdAx0b_ictRVk_HjUHhApnqUT_0pUIWYPsBJG30IWqcaNBtg>
    <xmx:FOmnagflCrT5k6SRpnQTwAv97Px-045TYXzf_DrPCVIE42g7FNMdXQ>
    <xmx:Fumnah0h-v9pcb7gzDMvwfnXkK4U9EfEMQXl9hLmWl0IXFjfDD7dFg2x>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 998D332A0081; Mon, 14 Sep 2026 08:31:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASHlnlKi8pPk
Date: Mon, 14 Sep 2026 14:30:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ulf Hansson" <ulf.hansson@oss.qualcomm.com>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Ulf Hansson" <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Johan Hovold" <johan@kernel.org>
Message-Id: <94445074-7cac-45ea-a051-8f521e4f6b07@app.fastmail.com>
In-Reply-To: <20260914111642.169707-1-ulf.hansson@oss.qualcomm.com>
References: <20260914111642.169707-1-ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH] mmc: vub300: Remove the driver for the obsolete HW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 14, 2026, at 13:16, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
>
> The Hw is obsolete since many years and its corresponding driver has not
> been actively maintained for a very long time.
>
> In this regards we are lately receiving a lot of AI generated bug fixes as
> the driver is a real mess. Rather than continue this path, with small fixes
> instead of making a proper rework of the driver, let's just remove the
> driver altogether.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>

I have no objections to removing the driver, but I think its worth
pointing out the actual year it was written (2010) to put into
perspective how young or old it is. Since this is a USB device,
there are likely still many of these in use on newer machines,
but they are also trivially replaceable.

I checked my series of driver removals to see if there are any
other mmc drivers that I already have patches for, but there are
none right now. There are two drivers that are used on relatively
old PC laptop: wbsd.c relies on ISA/LPC DMA, which become
unavailabl  on PCIe chipsets 20 years ago, while sdricoh_cs.c
relied on a PCMCIA or Cardbus slot that was phased out around
the same time when laptops started using Expresscard instead.

      Arnd
