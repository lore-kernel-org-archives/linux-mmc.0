Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158982;
	b=qfzdFl91os/cXzBuMlUIUvR8o1C/ec1BaOUtFG0c23iaWYlQTqAspRRLTSF7uHUuq0C7
	 yXOWKZ/F2XhS1puZmz7D7xJkBg7OkAgSOvlA90fIu4h8T5gCZ/VHBcPAtRb/FEWwOgMaz
	 N8LBAHvmgJto9My1KBXivFP0aBbFXtD93iO806bkR3/qa4gbZsu5n9mQ3RMnl90WW38QL
	 Q1dsOQAz9/ry6o+1hEcBZn1zY6IaSjVjp3QYLVy7biD20tg+2DBcBZW3dNbV+8Mu4TfNm
	 R58wSKf40/l1sRcc/qXmxiB1XF9fcCZadMEBV0Sp+49jZeJj3ne9UGxYCt6u4zXVACg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:Received:From:In-Reply-To:References:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=pr8bkjkApTHbP6ovsTmt0oEqwUCGjHFXMihoPuCHWKk=;
	b=VkGiDGIZ6paJtjIZSruAoSD1HX3xnMWkt/7Dvi1ocm3sum0RBPPQwcMoEyek4xNHXLLp
	 A/eUqbAmushDGYnkbjH19W6HzNUhCTR/5RasJG09MUwfWvwNBe9qhZGcmm1nWfYNMNaLR
	 leTyqMRPcJ1PzY7i953SzO06i4+2FjJJF9qTEx36Q4pIDmz+Y3DBa8ZT0zgRtxe/c3rQL
	 FU6KncADCuwFo8Jl8jRH8xCgLSoVmXQVfkJThtgiIvpPujevWBQIIWK/Nd6Uaf9DXcxa6
	 38bVw2vBrnBFeRTaLxPnXkn8EA+WfpTbNVpGEvCRLBBWzY2/nONmg7KUQmKflBRctXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starlabs.systems;
	spf=pass smtp.mailfrom=starlabs.systems;
	dkim=pass header.d=starlabs-systems.20260707.gappssmtp.com header.i=@starlabs-systems.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ov1c8D8m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484A606A325
	for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 07:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6484A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=starlabs-systems.20260707.gappssmtp.com header.i=@starlabs-systems.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ov1c8D8m
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677bc4704cbso830580d50.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 23:16:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795158980; cv=none;
        d=google.com; s=arc-20260327;
        b=YLicJZt/NPm/J25/H6b8vasgLXVGfwQvzdlmuzhZ8zXZGM7AxxHLyx/QwY91V2poms
         /wPfG04JzAzig0xzuD6kk6Ui2B5QEalr8GxZ7T0+MIicDqHM4JW0bLMvHyCAny/zwSTF
         KvbV+AGbXFD3jxxC6nNlCJlPOfgXc6Q6BRQm/LXG1/e3xKwE05clwekinxw8HjtphmrF
         Z3fwheDcCuPyJxwpxcpA2O/tMR8cxF9ADbYZuEgwN8a0LqOEwIIdxM8hW3OzspYJmgHE
         H4oEe73YSr6Yn35LbOLyP6hoMyGgj8QOdbBwlC0aCLmoFVpw8UExOo6hAL1XCpKa8gvh
         QXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=pr8bkjkApTHbP6ovsTmt0oEqwUCGjHFXMihoPuCHWKk=;
        fh=NRWrwtc8FnaNMetTnPXnSFYhlIhjQ0rDR5nC3a3ew2A=;
        b=fjnVSsoZl8kg1NPvKchaFXCuQ5K36Lfr3yKPIHSOvQkf+DmAKqrjO2BKYWtION5anm
         P8FSJicbmMTlLd1XbNHMCeZndZclYdLhgBVfkgNMzQmbd9PvAKv7w6d+3pmIDSOx7BBg
         cl0KETSU1Y/CSZc1Lu+m8RZzw0wEHHSfRMuqurAAwSxu71c29/IFfi68iFfKgfyWAjdn
         8uiPFwkfFBKWpJpuVAePFk4sGFdy3CfmBsFwmYKbGqk+HcuXN6Bb7yswWdDbNd0PR45y
         CogsOcMvZpJDQf4K9ZY4OcqLNriDjfN4Gg611j62GDhpYVjrJ9fUj38E8yZ4s5otTV+y
         IZIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20260707.gappssmtp.com; s=20260707; t=1795158980; x=1795763780; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pr8bkjkApTHbP6ovsTmt0oEqwUCGjHFXMihoPuCHWKk=;
        b=ov1c8D8mjWm9kow16X7x8uisJSk208PrK8Iowy6nmD/otsj5RiUm1shl54YJ5xty05
         amssDsK8nnqAGTrkpTMQdDsiSHk6kCgbuOWG5RFnJi6ZwDX7XHVFFtb+5aoXSzN0iXGQ
         QDX9ELyDa2E6wiFez+G+HNUiYIxNgGpQUYsUQEq4YL/fEd/A/8AquIh1LJm/5R2y3Qcx
         +F1VhpBFIzUiG+izA40iKQvbOApUGpH4VZAcFWJvrOGstSp7+2mCQJLwr8nbLrYg1CJU
         CoV4s1Sfz/Pb+vvuphrmuofS552rZtcyYoZpzmaRcq9sXy3NY/JzC8Aud2tYpqh/MOOG
         K8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795158980; x=1795763780;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pr8bkjkApTHbP6ovsTmt0oEqwUCGjHFXMihoPuCHWKk=;
        b=1hdeDS2pzemCder1x/tVxnWLHQFGoqlHKzj4lLlXQjmdELD73Vt8lpRcKwNfnI3Kbz
         eTvE4O4Zndt3cI/kzr1dtjg3qBDoqJ+GbdCZe1ZxHUsvHLZvPVxFj3w/QsIwjvC7fg/H
         fujbcAAq6u3lxYSxWr66BnOV20tNhet9FoekkDx/l6bleKElZUE1zhXbvLxmlWT6nKmT
         waqq4VBr0HWbCpDeMYWTtw13P6DyEHILZlNG6pgSt7wOKTrRoD7lR928FV/aDzI0+jGN
         PTaCIe7pOawLL+P2WAx9TG1hiGufDn4TQyTgFeZmafX7ft8HLhrmhZY1fCsM5qDY+bdV
         lZiQ==
X-Forwarded-Encrypted: i=1; AL+hErHO5KPl77owMLtUbIJgbV1w5OSXERtFU99+UNxslCIILiiqyREgwE8y6aMbZRFez/Ixyc8xpfZaiI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7QT4lTuSLXx4PoUj6REN5BxnGt0vOQAkfH022LE1VhkKxtxM8
	iI6wAhsmErOBIt4bb7bQiNw8NzMe/16eU6nNQ4knfeVVUb5RhG35DTPqkp9PFQYkCiyj1PRicNs
	2pMmPkW/gu8ahd2P2Y5Qu0yWDWMBXCpdk9aNgIMQF69vl+wcO5+k=
X-Gm-Gg: AZFdTZdlHQyYQQ3FfaVPXTGi6Lhp2WAVrBXud8bEA/+nKK38QXqU6SzenYrFjkETsLf
	LlR0znSEJ+qQ7SkEiJLFanRRbjPYroO1+aYb9qca6JRMzRVtcGbT8tr1B/xO34w4CK6qfOyyMIp
	Wnft3Oif5XX67pGAiE1jXe8XutfZHq/Du+tiW1CmzsjdT4f68YYewwRWwa5vIi8a5WL5q5S7OdE
	sIvd6PuhvRKzUZRh8rBulK+5VB0PcrK2RyAuV1ZPR3T60wzNH/dAkzFxmFUGpr25eqROe4Np/oz
	fYM1E3CMBuDjzT4eViyLYMRevQ72WAkAHNRUf7E/HD1lM4F8sEaUp0T1e4TENllit4FAfxvsO99
	n9mBZfwAKrBHOyEvto5oaAHc24WADr3UPQLNA/OXPaqPmx29NTzXVLDxowTeEcdrGiJVRcME/9B
	mIZ/F+comHSovhTGcuuNlvTaSgRWrTyA17DzMhIwNT5ATzgiSN
X-Received: by 2002:a05:690e:43c6:b0:67b:fd1d:4767 with SMTP id
 956f58d0204a3-67df4446b9dmr530623d50.88.1795158980194; Thu, 19 Nov 2026
 23:16:20 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 19 Nov 2026 23:16:19 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 19 Nov 2026 23:16:01 -0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Thu, 19 Nov 2026 23:15:09 -0800
From: Sean Rhodes <sean@starlabs.systems>
In-Reply-To: <DMZEIO23VCO0.2BB6F5495FHVG@web.de>
References: <523eb7d1cc0811df4a5e4c534538f3dd@web.de> <eb52777b-8607-427b-a709-cf1ab76ef672@leemhuis.info>
 <DMV8DI3F257U.DPLVLW2DZC3Z@web.de> <CABtds-3f_Gcsd6_vgcbqiAoN-9AUwHg5cr71VetRpO5jC4ZxFw@mail.gmail.com>
 <DMZEIO23VCO0.2BB6F5495FHVG@web.de>
Date: Thu, 19 Nov 2026 23:16:19 -0800
X-Gm-Features: AclHuK-rodRypXzXRwd_0Z1gPSs3n7Ipa9IRXGAJ2v7akGndaL_kFCK2Sj9nNWg
Message-ID: <CABtds-2rtzrB4mrcTnGXCTcbxG345-+ODcrAhd8=8WuV+11wJg@mail.gmail.com>
Subject: Re: [REGRESSION] rtsx_usb_sdmmc: RTS5129 (0bda:0129) no longer
 detects SD card
To: Philipp Jonas <pjjonas@web.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, linux-mmc@vger.kernel.org, 
	regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

Thanks - I don't have any cards that old to test with, but the attached
should work (borrowed from the old driver that was removed)

Sean

On Thu, 19 Nov 2026 at 18:53, Philipp Jonas <pjjonas@web.de> wrote:

> On Thu Nov 19, 2026 at 3:35 PM CET, Sean Rhodes wrote:
> > Hi
> >
> > Could you share the trace from a failing 7.3.4? And what card was it?
> >
> > Thanks
> >
> > Sean
> >
> > On Sat, 14 Nov 2026 at 20:54, Philipp Jonas <pjjonas@web.de> wrote:
> >
> >> On Wed Nov 11, 2026 at 10:06 AM CET, Thorsten Leemhuis wrote:
> >> > On 11/8/26 19:51, Philipp wrote:
> >> >>
> >> >> the SD card in the internal Realtek RTS5129 USB card reader
> >> >> (0bda:0129) of my Lenovo V110-15IKB is no longer detected.
> >> >>
> >> >> Works:  6.12.116, 7.2.x
> >> >> Broken: 6.18.x, 7.3.3
> >> >>
> >> >> On broken kernels rtsx_usb and rtsx_usb_sdmmc load and the platform
> >> >> devices rtsx_usb_sdmmc.0.auto / rtsx_usb_ms.1.auto exist, but no
> >> >> mmc host/card appears (no mmc0, no mmcblk0) and there are no errors
> >> >> in dmesg. Reloading rtsx_usb / rtsx_usb_sdmmc, re-inserting the card
> >> >> and disabling USB autosuspend (power/control=on) do not help.
> >> >>
> >> >> Since 7.2.x worked but 6.18.x does not, I suspect a change that was
> >> >> backported to stable.
> >> >
> >> > Might, but might not -- and I wonder if you have two bugs, some race,
> or
> >> > if some .config setting is disturbing something. Overall this
> situations
> >> > is somewhat puzzling. The best way to bring some light into this is
> >> afaics:
> >> >
> >> > Check if 7.2 is working; if it is, bisect between that and 7.3.3; of
> >> > not, bisect between 7.2 and 7.2.x to find what fixes things. And
> ensure
> >> > to use the same .config as a base during the bisection, as explained
> >> here:
> >> >
> >>
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
> >> >
> >> > dmesg outputs from a working and a not-that-different version that is
> >> > broken (say 7.2 and 7.3.3) would be helpful, too.
> >> >
> >> > Ciao, Thorsten
> >>
> >> I found the culprit:
> >>
> >>   7185b6d33b17 ("mmc: rtsx_usb_sdmmc: suppress false CD after init
> >> timeout")
> >>
> >> Reverting just that commit on top of 7.3.4 fixes it. Same kernel
> >> version and config, the revert being the only difference:
> >>
> >>   7.3.4:           card not detected
> >>   7.3.4 + revert:  card detected again
> >>
> >> dmesg with the revert:
> >>
> >> [    4.133620] usbcore: registered new interface driver rtsx_usb
> >> [    5.582812] mmc0: new high speed SD card at address b368
> >> [    5.638774] mmcblk0: mmc0:b368 SD 1.90 GiB
> >>
> >> Without the revert, nothing card related shows up after the
> >> rtsx_usb line.
> >>
> >> Hardware: Lenovo V110-15IKB, internal Realtek RTS5129 (0bda:0129),
> >> no tray, plain SD slot. The card is permanently inserted and holds
> >> a LUKS key, so it has to be detected during boot.
> >>
> >> Judging from the commit message, I assume an init command times out
> >> before the card is attached, suppress_cd gets set, and as the card
> >> is never removed, raw SD_CD never drops and the suppression is never
> >> cleared. Note that physically removing and re-inserting the card on
> >> 7.3.3 did not bring it back either, so the clearing path does not
> >> seem to work here as intended.
> >>
> >> Sean, Greg, Ulf: CCing you as author/acker/committer.
> >> Happy to test patches.
> >>
> >> #regzbot introduced: 7185b6d33b17
> >>
> >> Philipp
> >>
>
> Hi,
>
> Attached is the full dmesg from an unpatched 7.3.4, booted with
> rtsx_usb_sdmmc.dyndbg=+p rtsx_usb.dyndbg=+p mmc_core.dyndbg=+p
> The card was inserted the whole time.
>
> The relevant part:
>
> [    4.273107] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [    4.274391] mmc0: req done (CMD0): 0: 00000000 00000000 00000000
> 00000000
> [    4.277087] mmc0: starting CMD8 arg 000001aa flags 000002f5
> [    4.909018] rtsx_usb_sdmmc rtsx_usb_sdmmc.0.auto: rtsx_usb_get_rsp
> failed (err = -110)
> [    4.909149] mmc0: req done (CMD8): -110: 00000000 00000000 00000000
> 00000000
> [    4.909157] mmc0: starting CMD55 arg 00000000 flags 000000f5
> [    4.909313] rtsx_usb_sdmmc rtsx_usb_sdmmc.0.auto: cmd->error = -123
>
> After the CMD8 timeout every further command (CMD55, CMD1, and the
> retries at 300 and 250 kHz) fails immediately with -ENOMEDIUM. The
> same pattern repeats at ~82s after runtime resume.
>
> The card is a 2 GB standard capacity SD card, so most likely SD 1.x,
> which per spec does not respond to CMD8 at all. On 7.2 the core then
> simply continued with CMD55/ACMD41. With 7185b6d33b17 that CMD8
> timeout is treated as "no media", so I suspect all pre-SD 2.0 cards
> are affected, not just mine.
>
> Philipp
>

From e4226badb674c1b566efb8959bda6c0d89dd7529 Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 19 Nov 2026 21:51:26 +0000
Subject: [PATCH] mmc: rtsx_usb_sdmmc: allow legacy SD init after CMD8 timeout

According to the rts5139 staging driver, SD 1.x cards do not respond
to SD_SEND_IF_COND. On an RTS5129, a preinserted 2 GB SD card times
out on that command and the driver then rejects CMD55 and subsequent
initialization requests with -ENOMEDIUM. This prevents MMC core from
trying the legacy SD path.

Do not suppress card detection on a timeout from a no-data CMD8.
MMC SEND_EXT_CSD uses the same opcode with a data transfer, so retain
the existing timeout handling for that command. Keep refreshing the
physical card state and retain suppression on other discovery timeouts
to stop repeated probes of an empty tray.

Probably might maybe fix: 7185b6d33b17 ("mmc: rtsx_usb_sdmmc: suppress
false CD after init timeout")
Reported-by: Philipp Jonas <pjjonas@web.de>
Link: https://lore.kernel.org/r/523eb7d1cc0811df4a5e4c534538f3dd@web.de
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index bf37fab233cf..55fb83f29328 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -879,10 +879,12 @@ static void sdmmc_request(struct mmc_host *mmc,
struct mmc_request *mrq)
 finish_detect_card:
 	if (cmd->error) {
 		/*
-		 * detect card when fail to update card existence state and
-		 * speed up card removal when retry
+		 * SD 1.x cards can time out on SEND_IF_COND. Leave card
+		 * detection enabled for the legacy initialization sequence.
+		 * MMC SEND_EXT_CSD shares the opcode but carries data.
 		 */
-		if (!mmc->card && cmd->error == -ETIMEDOUT)
+		if (!mmc->card && cmd->error == -ETIMEDOUT &&
+		    (cmd->opcode != SD_SEND_IF_COND || data))
 			WRITE_ONCE(host->suppress_cd, true);
 		sdmmc_get_cd(mmc);
 		dev_dbg(sdmmc_dev(host), "cmd->error = %d\n", cmd->error);
-- 
2.53.0
