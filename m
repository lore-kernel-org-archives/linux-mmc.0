Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD64C04A95
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 13:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJYNgS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiJYNgR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 09:36:17 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383D1D0CD
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 06:36:13 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4MxXyb2vRGz9smk;
        Tue, 25 Oct 2022 15:36:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1666704967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=e0InZQvgNMylNlF+339YHDWoaN5OuzY308gWMP7s1pQ=;
        b=OiOeW1rrarO5JQnucMxsZSO8Sb27xVg1CIskRMyznAAF2+gORpG3uL26ijtlDq5LtiGXDP
        iDLNS53pT2DkHFQ4DC1evUvv4se15c4qQXX2nyDe5hO+If0jj3UgaERqPYjHmu45+a3+iK
        8XUE18PtP6sPDzenUfqf97imRMBemD/uocc/TLcvZGf5yfYE7bsKpXG8ckA189VpS95taK
        /VMnBBCzSRspocFNL7/TBgin9hKNvL0OHrjVOSyKE0Uk2uhtrEtSGYDobnc+7Jrb7FCz6w
        sF8V6zLyZixd4P0WvEYjelru0PmliVh9IW2lbocSCpQaJzsG7MdGBSRKHX3qsg==
Date:   Tue, 25 Oct 2022 15:36:02 +0200
From:   Andreas Radke <andreas.radke@mailbox.org>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Subject: constant media change events - hardware or driver problem?
Message-ID: <20221025153602.3cacaae6@workstation64>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vkFsUNecJN8W5CcsCr1/Rw_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-MBO-RS-META: ijcfbymf9wcw7qjy199s13xzi4prk4x1
X-MBO-RS-ID: 68e0e1f7ba69928465f
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--Sig_/vkFsUNecJN8W5CcsCr1/Rw_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

My Zotac Ci323 system with builtin sd-card reader keeps firing off
media change events" DISK_MEDIA_CHANGE=3D1". It may be a driver or
hardware problem and was detected by some systemd changes introduced
between v250 and v251.=20
Please have a look at https://github.com/systemd/systemd/issues/25021.

I've already updated to latest Zotac bios 2K210510. There's
currently no related kernel module loaded due to blacklisting
sdhci_pci/sdhci/cqhci/mmc_core modules.

I can stop the mess when inserting an unneeded sd-card into the slot.

lspci -vvs 00:10.0
00:10.0 SD Host controller: Intel Corporation Atom/Celeron/Pentium
Processor x5-E8000/J3xxx/N3xxx Series MMC Controller (rev 21) (prog-if
01) Subsystem: ZOTAC International (MCO) Ltd. Device b301 Control: I/O-
Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency: 0, Cache Line
>Size: 64 bytes Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 81516000 (32-bit, non-prefetchable)
[size=3D4K] Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
DSel=3D0 DScale=3D0 PME- Kernel modules: sdhci_pci

Can you help me to find out if there's something wrong in the linux
kernel / maybe a driver or subsystem bug or if this a hardware issue?

Should I file some kernel bug?

-Andy
Arch linux

--Sig_/vkFsUNecJN8W5CcsCr1/Rw_
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmNX5kIACgkQlGV6sg8q
CSvwAQf+PdO0kCZqZXEdnUDMKz8wntr9Jn2UtThryL9RpL5eoL9ShG6e4xmR8hnF
ZT0Ceo5oKE/9QwijovFrACd2OL/4it3/Dh47zDGy8KuOSHjzsxNDdPG7NUXTtyGq
hogjslMVeaPoAUa+1QdCbRLywg8tOo91A5sDQ1BHe5nrJNtZCUUe/dD93lf+zfnT
9YqDLiQsuao8oRsL6VuLVM9uEoGr6ieUxnab1i/Ul87ibOQinDxb285ZcWaa1Oib
fbFBlT6Z6fG/ERO1MPa9Ngmxhjppwyget/3xR5Bp5PLLY77q5/Xn6cDpvrnDchqI
1KLm79KSCwl+j7dlgw7ew7HGIGUJ4g==
=vPpO
-----END PGP SIGNATURE-----

--Sig_/vkFsUNecJN8W5CcsCr1/Rw_--
