Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703665;
	b=Xs1crOE/nxWeV4Iq1yvdjsVLldB7nOxkklAvLD/Kof2QfZwhn41duYz272UrN044N29s
	 CWDPrz4G2aN9/V+pJoKexDpoKSJAvV8KMBtf4brT5yHPcMewO0xzh3/JZ4z7XQ8fM/EXW
	 o0MY1ceCb0IyPd0XfoFfDDBt3oF91FYDL4DvO4lZvRDU39Oz0tHc/AiyzsR7BL6/Kb5NL
	 jxhVboCgClnQDp+I8uooYkP+dfkT4kvgX0Rja5KhVIWW8zv62kOq7ZvgB8t67nOyBCk3t
	 PmqjVo8bXJpSCKqOPG1yOa0j6LoGQMImLnNRmMkEPw7cstiyP5W/VucsCO9IshjCOgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703665;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=LsOEhasSokGNxYESCQCO9GTHff8GmmBcIJpuHTh3t+0=;
	b=EiNQKNXvBwJb9731JwhhQUzUBoKm93gf3RBMslN7yG6UJWBeZDxw2Qe40NnADr9LfXkf
	 R0qd5QoFHGyey9rYxHSX9qcqaoB4/m5zdU6CU5PFq76z2jSUtPphrC8xs/kFMTU7lbc2n
	 rLLhIr6yeb++1ediDxaObXYNzJlLleO/LDhbU2yxZWGfE+FstZJZx4zKEdyp4Lkz1Goyw
	 tWUfxaoe6AxfFI1yBZecHwiyDPH1LgjQ6InHXfuV/iaOL/ONpM0mummmZlVLrvDptEki8
	 zBJWV7Dk24URjElsMVsFRgE806qjMgkSe0YUfvR/7sRfbEDRxQrAiHUSF2DYgK23GRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TTLP56cc;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C61606A319
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 21:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7C61606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TTLP56cc
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso105388a12.2
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 14:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703664; x=1793308464;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsOEhasSokGNxYESCQCO9GTHff8GmmBcIJpuHTh3t+0=;
        b=UUgYkvLCSIj65d0nrtsNHh6EvU0UbtXC6PS6t+7IucJfk0mqg40eMqkB51HPYlNI9m
         k67X9uIUYGlyj/2Ei0fv5QPGzbJ8e90Y1iZ53oVNQzrTV9hOgsTJ3gw0xJfCKDVHwuXL
         0j0bh3sKdfUvn08DtXZNZaKkUxHpwM8aS37/t9Ld3Gff1XD6j+0Ms4DhiHk9u9ns1Fqh
         CVLZjZyYa51PNxyKrXMnpbFLLB0PLpQjxPDrKSU6bjbvYy/MUJHL17ofaAAIw0jok5W6
         PESZ8xtqYW9EDWGfQusb4LHE/31ipmd3t+R7i3gigsJhkDjR+aSgNBzncaqhQKV25yGa
         nZiA==
X-Forwarded-Encrypted: i=1; AKwUvBxD3+/bp5uAxTB9jt9UGtVsdOV3mIdkMh3UakyAEaUw5mZo6Urrfnw66act4Eu6uBhdorHLen9TUa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBhNPuukiU5902MVdJic6e3W5LJBjPvzfi71g0AbeA3ZaEcDkC
	1dSNhfb6Y6yxZE2vFfMwn24XHXjU+QLVLb1noV7Fh57DFCp2vSLzIQF7y7y8RViYsgRQZ7sPfRU
	yt17F+Lvwt1rp0tassHA+iFUUjcWXSVjbd71EORgz5KC1/nMEE0SNrkBOFIw8h5chgKJ4Ldagaj
	g1/kPYmJYHfuJjmv5uMF43/YVH1qJsApAQmKIgs+QZlQUB8bYUg6/4NrVyK/Z+vPGkGTPRdX5S2
	XfoMBJAB+zN
X-Gm-Gg: AYBFou2rnGTJHPHkPrSFtxovJBFaM6/k96Vq3lOGGkgl5akBkcBR9G1/Ujo1WtGGtXg
	ZbEkcP1f/pztPUKvsTjE/kk+e9t0epj/Q7DlQmF9oBw787xDeXg/n42RH3wXU4h3ElzFXRj8CZn
	usuWRgtzgATBoGZB+D72Ec6PYz/afnegNp89ajJH3qRHKBTwccObT9ZOt3ygbI7rfNM+OuPIr65
	tM62Uc8K+HLzuD2SfXJOi9BRLlI91LZ81n+KPj49CK3YSIszmqp9bUX+sT/lxUcmdByymiWlXyV
	N2/R6Zo7S/5rnKR3f2qDKuj0rEX9lDvAOmAVtwn/8XriFkJesfpfpghcgzYtLNXjsI5Ihf7YNoJ
	rhGimx9mtXBIdeFT4EXqs9GsJa/cQiNVLOSY9vZfyXj6N5KeNC+E3boIPvo1AblngI64j87M+wL
	z+U1cUhhHqr6oMXGNNA0AOWaHlfz/MPLjZ
X-Received: by 2002:a17:90a:ec87:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3adce7d6a28mr65586a91.50.1792703663897;
        Thu, 22 Oct 2026 14:14:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adcddf13b1sm68142a91.5.2026.10.22.14.14.23
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:14:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso843721eec.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792703662; x=1793308462; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsOEhasSokGNxYESCQCO9GTHff8GmmBcIJpuHTh3t+0=;
        b=TTLP56cc6UZCFyiSILZ54zqWFdyHcVWTdyZ4xQk2kLfqplma9yp7RFe+tjhnyp2gbb
         odl7PsOqc5rapl5e/AigE31ml9v6RAbXk2Z32y2CkDx2/mNIhAOtGBwwW8zscSZnc/P3
         PPmpXHyf6NhRWTNay35gQNzvSts1TYoSvEm8s=
X-Forwarded-Encrypted: i=1; AKwUvBzDBzquDNYIv7grq6VpEvXle0WAnKLcuXmAyXodfAbrnADGjNEARFwnt2DTeqevTTpd8jW5L4ukYjA=@vger.kernel.org
X-Received: by 2002:a05:701b:2701:b0:151:2068:e81f with SMTP id a92af1059eb24-195c26fe967mr547327c88.27.1792703660898;
        Thu, 22 Oct 2026 14:14:20 -0700 (PDT)
X-Received: by 2002:a05:701b:2701:b0:151:2068:e81f with SMTP id
 a92af1059eb24-195c26fe967mr547282c88.27.1792703660067; Thu, 22 Oct 2026
 14:14:20 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260811163810.1599747-1-kamal.dasu@broadcom.com>
 <20260811163810.1599747-4-kamal.dasu@broadcom.com> <CAPx+jO9Gpjb5b8ZpYypCshxKaaK80b5t2TJQTb-pCzas7z8q_A@mail.gmail.com>
In-Reply-To: <CAPx+jO9Gpjb5b8ZpYypCshxKaaK80b5t2TJQTb-pCzas7z8q_A@mail.gmail.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Thu, 22 Oct 2026 17:13:42 -0400
X-Gm-Features: AclHuK8pel21VWAjxLEAPv4rRGS_0EiubXLNQPFqJqaEFDySVWgfKAlMgeLi8oQ
Message-ID: <CAKekbetFSCXtOAgKYH=sPsv1ykB1CorhhGueYsUvBFowN+CWkQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mmc: core: Honor keep-power-in-suspend and
 reset-card-at-resume for (e)MMC
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Avri Altman <avri.altman@sandisk.com>, Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, 
	Erick Shepherd <erick.shepherd@ni.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fa6bf4065e745868"

--000000000000fa6bf4065e745868
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 9:59=E2=80=AFAM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:
>
> On Tue, Aug 11, 2026 at 6:40=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.c=
om> wrote:
> >
> > On some platforms, firmware accesses the (e)MMC card directly during
> > resume from Suspend-to-DRAM, before the kernel's own resume path has
> > run, in order to load boot code. This requires the card to remain
> > powered and responsive throughout suspend: putting it to sleep,
> > sending it a power-off notification, or removing its supply is not
> > safe, since firmware needs to talk to a live card. Since the card is
> > never power-cycled, nothing else resets it back to a known state
> > before the kernel reuses it after resume.
> >
> > keep-power-in-suspend / MMC_PM_KEEP_POWER already exist for the first
> > part, but are only consumed in the SDIO suspend/resume path
> > (mmc_sdio_suspend()/mmc_sdio_resume()), gated on a per-function
> > runtime request via sdio_set_host_pm_flags(). (e)MMC has no
> > equivalent function-driver layer to make that request, and the
> > requirement here is a fixed platform characteristic rather than a
> > per-cycle one, so _mmc_suspend() checks host->pm_caps directly
> > instead of pm_flags.
> >
> > reset-card-at-resume covers the second part: when set, _mmc_resume()
> > resets the host to its initial bus state the same way _mmc_hw_reset()
> > does for a non-power-cycle reset, before mmc_power_up() and
> > mmc_init_card() re-identify the card.
> >
> > _mmc_suspend()'s fast path requires both MMC_PM_KEEP_POWER and
> > MMC_CAP2_RESET_AT_RESUME to be set. Keeping the card powered without
> > also resetting it at resume is not safe for this driver: skipping
> > mmc_power_off() leaves power_mode at MMC_POWER_ON, so mmc_power_up()
> > no-ops in _mmc_resume(), and without an explicit reset first,
> > mmc_init_card() runs against whatever bus speed/width was active
> > before suspend instead of the initial state it expects. Conversely,
> > _mmc_resume()'s reset checks pm_flags rather than the
> > MMC_CAP2_RESET_AT_RESUME capability directly, since pm_flags is only
> > set when the fast path actually ran -- the only time power_mode is
> > guaranteed to still be MMC_POWER_ON, and so the only time resetting
> > the bus before mmc_power_up() is both necessary and safe. Without
> > that check, MMC_CAP2_RESET_AT_RESUME set on its own would drive the
> > clock and bus lines while the card's supply is still off following a
> > normal mmc_power_off().
> >
> > The fast path also leaves the card marked suspended without powering
> > it off, so _mmc_suspend()'s pre-existing early exit for an
> > already-suspended card can no longer assume there is nothing left to
> > do: a shutdown, unbind or undervoltage event can still arrive before
> > the card's next real access lazily triggers _mmc_resume() via runtime
> > PM, and those events need the normal power-off sequence regardless.
> > Reselect the card and continue into that sequence in that case,
> > instead of returning early and silently skipping mmc_poweroff_notify()
> > and mmc_power_off(). Reset the host to its initial bus state first,
> > the same way _mmc_resume() does, since firmware may have left the
> > card in a state that doesn't decode reliably at whatever clock/timing
> > was negotiated before suspend -- otherwise mmc_select_card() itself
> > can fail and abort into that same early exit, before ever reaching
> > the sequence it was supposed to fall through to. If mmc_select_card()
> > still fails after that reset -- the card may genuinely be gone -- fall
> > through to mmc_power_off() directly rather than aborting again:
> > unlike the other steps here, powering off doesn't need a responsive
> > card, and shutdown/undervoltage need the supply actually removed
> > regardless.
> >
> > host->pm_flags is set alongside marking the card suspended, and
> > cleared in _mmc_resume(), so host controller resume handlers can tell
> > power was preserved if they need to.
>
> While I certainly appreciate a descriptive commit message, this is a
> bit overwhelming. Please consider making commit messages a bit less
> wordy and more to the point.
>
> By reading the above, it becomes clear to me that we should really
> split this patch. Both for reviewing purposes, but also to use the
> step-by-step approach.
>
> I believe the first the patch should take care of the updated
> interpretation of MMC_PM_KEEP_POWER for eMMC and a second patch on top
> should deal with the "reset-card-at-resume" thing.
>
> Anyway, I understand the code in the mmc core for power management is
> somewhat tricky to follow. Rather than continue to provide you with
> in-depth guidance and review comments, allow me to spend a couple of
> days trying to make the implementation for the above and send out a
> few patches that you can test.
>

Please let me know if you want me to fix the above issues and send a v10.

Kamal

> Kind regards
> Uffe
>
> >
> > Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Closes: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fain=
elli@broadcom.com/
> > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > ---
> > Changes in v9:
> >   - Sashiko's AI review found two more High severity issues in the
> >     same shutdown/undervoltage fallback added in v8:
> >       * Calling mmc_select_card() straight after finding the card
> >         still marked suspended assumed the card would respond to
> >         CMD7 as-is, but that's exactly the assumption
> >         reset-card-at-resume exists to distrust -- firmware may have
> >         left the card unable to decode commands at whatever
> >         clock/timing was negotiated before suspend. A CMD7 timeout
> >         there hit "goto out" and skipped the power-off sequence
> >         entirely, the same failure mode this fallback was added to
> >         close in v8. Fixed by resetting the host to its initial bus
> >         state before mmc_select_card(), the same way _mmc_resume()
> >         already does before touching the card.
> >       * Even with that reset, mmc_select_card() can still legitimately
> >         fail (card genuinely gone). The code still unconditionally
> >         "goto out" in that case, skipping mmc_power_off() entirely --
> >         but mmc_power_off() is host/regulator-side only and doesn't
> >         need a responsive card, so there's no reason a select failure
> >         should leave the supply on indefinitely for a shutdown or
> >         undervoltage event, or leave pm_flags/suspended state stuck
> >         retrying the same failing select on every later call. Fixed
> >         by falling through to mmc_power_off() directly on select
> >         failure instead of aborting.
> >   - Patches 1/3 and 2/3 are unchanged from v8.
> >
> > Changes in v8:
> >   - Sashiko's AI review of v7 found a High severity issue: the
> >     keep-power fast path marks the card suspended without powering
> >     it off, but the pre-existing early exit at the top of
> >     _mmc_suspend() (for an already-suspended card) doesn't know that
> >     -- it just returns immediately regardless of pm_type. Since the
> >     system-resume path only re-enables runtime PM rather than calling
> >     _mmc_resume() directly (that happens lazily, via runtime PM, on
> >     the card's next real access), a shutdown, unbind or undervoltage
> >     event landing before that next access would hit the early exit
> >     and silently skip mmc_poweroff_notify()/mmc_power_off() entirely.
> >     Fixed by reselecting the card and continuing into the normal
> >     power-off sequence whenever the card is suspended via our fast
> >     path but pm_type isn't a plain suspend, instead of a bare early
> >     exit. Calling _mmc_resume() itself from here isn't an option, since
> >     _mmc_suspend() already holds the host claim.
> >
> > Changes in v7:
> >   - Sashiko's AI review of v6 found two real, complementary bugs in
> >     treating MMC_PM_KEEP_POWER and MMC_CAP2_RESET_AT_RESUME as fully
> >     independent in this driver:
> >       * keep-power-in-suspend without reset-card-at-resume: confirmed
> >         on hardware to hang -- _mmc_resume()'s mmc_power_up() no-ops
> >         since power_mode never left MMC_POWER_ON, so mmc_init_card()
> >         runs at the pre-suspend bus speed and CMD1 times out.
> >       * reset-card-at-resume without keep-power-in-suspend: the reset
> >         block ran mmc_set_clock()/mmc_set_initial_state() ahead of
> >         mmc_power_up(), while power_mode was still MMC_POWER_OFF from
> >         a normal suspend-time mmc_power_off() -- driving the clock
> >         and bus lines before the card's supply is enabled.
> >     Fixed by requiring both capabilities together for the suspend
> >     fast path, and checking pm_flags (not the raw capability) for the
> >     resume-side reset, so it only ever runs when power was actually
> >     kept this cycle. Verified on hardware: the keep-power-in-suspend-
> >     without-reset-card-at-resume case now correctly falls through to
> >     a normal power-off/power-on cycle instead of hanging, and the
> >     paired-capability case is unaffected (still hardware-verified,
> >     now with an extra confirmation run after this fix).
> >
> > Changes in v6:
> >   - Reworked around Ulf's two-property split: dropped the
> >     unconditional mmc_set_clock()/mmc_set_initial_state() reset from
> >     the suspend-side fast path, and instead perform it in
> >     _mmc_resume(), gated on the new MMC_CAP2_RESET_AT_RESUME (from
> >     reset-card-at-resume), matching the property's name and
> >     description ("before the card can be used, it must be reset").
> >   - No longer touches MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-
> >     suspend at all -- that capability and property are gone, per the
> >     v4 rework; this patch only adds MMC_CAP2_RESET_AT_RESUME.
> >
> > Changes in v5:
> >   - Only set host->pm_flags |=3D MMC_PM_KEEP_POWER after
> >     mmc_deselect_cards() succeeds, instead of unconditionally before
> >     it. Otherwise, if the deselect fails, the card is never marked
> >     suspended, _mmc_resume() takes its early exit, and the flag never
> >     gets cleared -- leaking it for the rest of uptime.
> >
> > Changes in v4:
> >   - Gated the fast path on pm_type =3D=3D MMC_POWEROFF_SUSPEND; it was
> >     previously unconditional, so it wrongly skipped the required
> >     power-off/notify handling during shutdown, unbind and
> >     undervoltage as well.
> >   - Set/clear host->pm_flags |=3D MMC_PM_KEEP_POWER around the suspend/
> >     resume, mirroring the SDIO convention, so host controller resume
> >     handlers can tell power was preserved and perform a soft resume
> >     sequence instead of assuming power was lost.
> >   - Dropped MMC_CAP2_NO_POWEROFF_SUSPEND and the no-mmc-poweroff-
> >     suspend DT property entirely. Reuse keep-power-in-suspend /
> >     MMC_PM_KEEP_POWER instead, per Krzysztof's point that the new
> >     property described the same contract as the existing one.
> >     _mmc_suspend() now checks host->pm_caps directly rather than
> >     pm_flags, since (e)MMC has no per-function driver to make the
> >     dynamic sdio_set_host_pm_flags()-style request SDIO uses.
> >
> > Changes in v3:
> >   - Reworked _mmc_suspend() to skip poweroff-notify/sleep/power-off
> >     entirely, not just SLEEP, per Ulf.
> >   - Renamed to MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-suspend.
> >
> > Changes in v2:
> >   - Replaced the card-level MMC_QUIRK_BROKEN_SLEEP quirk with a host
> >     capability, per Ulf.
> >   - Added Reported-by/Closes crediting Florian.
> >
> >  drivers/mmc/core/host.c  |  2 +
> >  drivers/mmc/core/mmc.c   | 98 +++++++++++++++++++++++++++++++++++++++-
> >  include/linux/mmc/host.h |  1 +
> >  3 files changed, 99 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index b7ce3137d452..1622f7846441 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -400,6 +400,8 @@ int mmc_of_parse(struct mmc_host *host)
> >         if (device_property_read_bool(dev, "no-mmc-hs400"))
> >                 host->caps2 &=3D ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400=
_1_2V |
> >                                  MMC_CAP2_HS400_ES);
> > +       if (device_property_read_bool(dev, "reset-card-at-resume"))
> > +               host->caps2 |=3D MMC_CAP2_RESET_AT_RESUME;
> >
> >         /* Must be after "non-removable" check */
> >         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &dr=
v_type) =3D=3D 0) {
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 05444ecf3909..3a0855a4ca44 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -2144,8 +2144,55 @@ static int _mmc_suspend(struct mmc_host *host, e=
num mmc_poweroff_type pm_type)
> >
> >         mmc_claim_host(host);
> >
> > -       if (mmc_card_suspended(host->card))
> > -               goto out;
> > +       if (mmc_card_suspended(host->card)) {
> > +               /*
> > +                * Nothing to do for a redundant suspend call. Otherwis=
e, the
> > +                * card can only still be marked suspended here because=
 the
> > +                * keep-power fast path below left it powered and merel=
y
> > +                * deselected -- reselect it and continue into the norm=
al
> > +                * power-off sequence below, since shutdown, unbind and
> > +                * undervoltage need mmc_power_off() regardless of how =
the
> > +                * card got here.
> > +                */
> > +               if (pm_type =3D=3D MMC_POWEROFF_SUSPEND ||
> > +                   !(host->pm_flags & MMC_PM_KEEP_POWER))
> > +                       goto out;
> > +
> > +               /*
> > +                * Firmware may have accessed the card while it stayed
> > +                * powered through suspend, leaving it in a state the k=
ernel
> > +                * can no longer assume it knows. Reset the host to its
> > +                * initial bus state first, same as _mmc_resume() does =
before
> > +                * touching the card, so mmc_select_card() below is tal=
king
> > +                * at a clock/timing every card is guaranteed to decode
> > +                * rather than whatever mode was negotiated before susp=
end.
> > +                */
> > +               mmc_set_clock(host, host->f_init);
> > +               mmc_set_initial_state(host);
> > +
> > +               if (!mmc_host_is_spi(host))
> > +                       err =3D mmc_select_card(host->card);
> > +
> > +               if (err) {
> > +                       /*
> > +                        * The card still isn't responding even after t=
he
> > +                        * reset above -- it may genuinely be gone. Not=
hing
> > +                        * else below needs a responsive card except
> > +                        * mmc_power_off() itself, which is host/regula=
tor
> > +                        * side only, so cut power directly instead of
> > +                        * leaving the card's supply on indefinitely (a=
nd
> > +                        * pm_flags/suspended state stuck retrying this=
 same
> > +                        * failing select on every later call).
> > +                        */
> > +                       mmc_power_off(host);
> > +                       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> > +                       mmc_card_set_suspended(host->card);
> > +                       goto out;
> > +               }
> > +
> > +               mmc_card_clr_suspended(host->card);
> > +               host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> > +       }
> >
> >         /*
> >          * For the undervoltage case, we care more about device integri=
ty.
> > @@ -2157,6 +2204,33 @@ static int _mmc_suspend(struct mmc_host *host, e=
num mmc_poweroff_type pm_type)
> >                         goto out;
> >         }
> >
> > +       /*
> > +        * Keep the card powered across an actual suspend; shutdown, un=
bind
> > +        * and undervoltage still need the normal power-off path below,
> > +        * since they aren't guaranteed a subsequent _mmc_resume().
> > +        *
> > +        * Check pm_caps, not pm_flags: unlike SDIO, (e)MMC has no
> > +        * per-function driver to request this via
> > +        * sdio_set_host_pm_flags(), so it's a fixed platform trait her=
e.
> > +        *
> > +        * Require MMC_CAP2_RESET_AT_RESUME too: without it, _mmc_resum=
e()
> > +        * has no way to bring the host back to a state mmc_init_card()=
 can
> > +        * use, since mmc_power_up() no-ops when power_mode is already
> > +        * MMC_POWER_ON. Keeping power without also resetting at resume=
 is
> > +        * not a safe combination for this driver.
> > +        */
> > +       if (pm_type =3D=3D MMC_POWEROFF_SUSPEND &&
> > +           (host->pm_caps & MMC_PM_KEEP_POWER) &&
> > +           (host->caps2 & MMC_CAP2_RESET_AT_RESUME)) {
> > +               if (!mmc_host_is_spi(host))
> > +                       err =3D mmc_deselect_cards(host);
> > +               if (!err) {
> > +                       host->pm_flags |=3D MMC_PM_KEEP_POWER;
> > +                       mmc_card_set_suspended(host->card);
> > +               }
> > +               goto out;
> > +       }
> > +
> >         if (mmc_card_can_poweroff_notify(host->card) &&
> >             mmc_host_can_poweroff_notify(host, pm_type))
> >                 err =3D mmc_poweroff_notify(host->card, notify_type);
> > @@ -2217,9 +2291,29 @@ static int _mmc_resume(struct mmc_host *host)
> >         if (!mmc_card_suspended(host->card))
> >                 goto out;
> >
> > +       /*
> > +        * Firmware or other hardware may have accessed the card while =
it
> > +        * stayed powered through suspend, leaving it in a state the ke=
rnel
> > +        * can no longer assume it knows. Reset the host to its initial=
 bus
> > +        * state like _mmc_hw_reset() does for a non-power-cycle reset,
> > +        * before mmc_init_card() re-identifies the card.
> > +        *
> > +        * Check pm_flags, not the MMC_CAP2_RESET_AT_RESUME capability
> > +        * directly: pm_flags only ends up set here when _mmc_suspend()
> > +        * actually took the keep-power fast path this cycle, which is =
the
> > +        * only time power_mode is guaranteed to still be MMC_POWER_ON =
(and
> > +        * so the only time this reset is both necessary and safe to do
> > +        * before mmc_power_up() touches the bus).
> > +        */
> > +       if (host->pm_flags & MMC_PM_KEEP_POWER) {
> > +               mmc_set_clock(host, host->f_init);
> > +               mmc_set_initial_state(host);
> > +       }
> > +
> >         mmc_power_up(host, host->card->ocr);
> >         err =3D mmc_init_card(host, host->card->ocr, host->card);
> >         mmc_card_clr_suspended(host->card);
> > +       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> >
> >  out:
> >         mmc_release_host(host);
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index ba84f02c2a10..14a407a9f9b7 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -463,6 +463,7 @@ struct mmc_host {
> >  #define MMC_CAP2_CRYPTO                0
> >  #endif
> >  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that =
has GPT entry at a non-standard location */
> > +#define MMC_CAP2_RESET_AT_RESUME (1 << 29)     /* Card must be reset b=
efore use at resume */
> >
> >         bool                    uhs2_sd_tran;   /* UHS-II flag for SD_T=
RAN state */
> >         bool                    uhs2_app_cmd;   /* UHS-II flag for APP =
command */
> > --
> > 2.34.1
> >

--000000000000fa6bf4065e745868
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H0K0rs+X8O45xZIUJlxzf5UZex3BLi1f/H+08rSQULWEtO/ECwkFod2DIzSX7fZdz5RQ1PpziEOp
goo/JZPYIeCmgt3rIyvMuupj8Ymb0J/velhpXfQuYUM52viw2nmqVcxCwBqyM3Iq7eI4xtEOFRmR
wxSizd3MSQMf6GCHA4/B/6ttnxhGAr3utaOU+x/RnzG0gPLTW1XRAQ0+GVc/tGFdI864OG1cyrRl
GvBnHJQSAFOIKwYrUk2oFpgMbafQ6osCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQEAwIFoDAMBgNV
HRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIgYDVR0RBBswGYEX
a2FtYWwuZGFzdUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAU
ACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFOV9h+N/T9ZsJ40qRxh7NYYD+N6MMA0GCSqG
SIb3DQEBCwUAA4ICAQAKtKh30wv1/30230mCimgUjMWQE/LImRmyfDgrp2IhBVS6mDun+wH8thEB
WhBHQMz3gsGixU4ZBJG72eWi39IzQ7CGnisJwA0+hsGaGg03AVtFtqo1rXYRZ81MEDOb6BPYLigJ
RsHbNmrUGR+LsGeUwOWUeRXqBrYaYFrkgHKvVK1NEewv+vUY08n4tsezO3jq0HKhVDY46bMbf8vL
oQqqhtcQvu2+5FK2jpUayeubpzPwobjEG61RIhBvM0KivY4CB2s9A7qgjL1XBycAybIvG03BbFoT
t282FqXwk9JU6YihLlt+hpzO9UF7E8GZYlQlVIZOLOvytqilhua+2h77Yy8Jz/FJyIXKuaLPtvb2
SC2shL7jF28kQbP3QUKwAig+cxwbpngnUkd9D9cXSHVq9PPwYm0A4eAO0YQ/80Uq20+gXF++g0sy
NKrrV3i0T1dbCd86miGDKvarGzjh7pdsdwNY15liGP6Orib1tnWkJcbtP1rJty4r/mbbxcK8ILO4
IvTGFG6BfjJ+La0aRt69i1fQmjUWHLwzkLNpw9cJH8/MONZcEJeDkq9WELSyy29bagStk5KHu7NO
TH65sZg+i/4qmj3DEeEGTr/Shzp4YWSNn4W7NEelr0VgDlwa7xqlwZjXxG4MIJqy0SsQlAwEXtqd
nH2FpJfzgAetkuyU6DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEca
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg4X3ZptQtbXp5KcCA
yBTyI+LseyKTV01LHXMHfUJ43ncwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYxMDIyMjExNDIyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAczoRVgwwlI7GYF3F9D4HL+aOf10csfcBkj9hglonxLQL2eZIJ7PU
FBxCaPREUAU0D/K2Kh65MIHSgCBuKSYcFWOkihoJe3qeHcJRF4S3/k7y6PqHSZo2SaqVGZ2i70yi
cmW0vO/hjHyBjE7iWiYp1eUmhSbYprKSW6EyPcdBmnvz0B91c7dD4fLw9aLlWbuH1Nzi0gRfkTU6
IX9ldAkWXFXhf59pLAvLulMp39b3g18yEEzNghGK4SK9kZY3ZVHNfb+jgaVus+SiHSDYyVBEx9d2
RAWbVBggSdzvpMiERsEdVlII+/FW9pSWrSuA2bCr9GehdT89ijE5MWKqfivY0A==
--000000000000fa6bf4065e745868--
