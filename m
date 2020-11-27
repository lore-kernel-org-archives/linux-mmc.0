Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106EAC2D0E4
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 03:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E57221FF
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 03:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzUnt9I3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgK0DuL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 22:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgK0DuL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2020 22:50:11 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A92C0613D1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 19:50:09 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s9so4412473ljo.11
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 19:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AagAkDLcDM4prsaMPWQhy/MLdX43TaW/lOI5pKjqlgY=;
        b=mzUnt9I3Knk1DRL7qZMJFXcooiwgLEZoXy6LvobBfuVEuWxAJpn4c7sP0oyDlYrDVk
         mrsuNrf9StBEFmm9TN2cs3RgQXR+FvOtU/cKyXEpSeQK2Y0MKfQC+RkDjGQ4NuUJyhS0
         Xi1jCB+kUn/IfgSG2JtBwGPHrzB/boJBlEHzxVLritRYKVTKcAV1LZZY2MDi3MKJMbZs
         z0CFbf3qHgrEg4+SlSWLzxwM/XSv0fyKewFePICYSw7qlLv2hOLSEGu3IaOi7wW7U3zz
         5M7JFInr4QYHAiz3uBdOZwt04vkLDw7f2Qc7PPh93B0A6gpURWHqy3+Tis1PCCTYuHt3
         mfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AagAkDLcDM4prsaMPWQhy/MLdX43TaW/lOI5pKjqlgY=;
        b=Wlj0Q/A/nPOj9DqNnYCBvjfPSo4+oLd97bRJQlSI8Udn6pbAU3bJg6nUC6C5X5r0rP
         I8BYyYhD8NaYWfgbgCoIxde3+vIbsZFsSkMmYBVTLh1zrjUwaD2iJgk7Tz+dLNQ5VYyx
         MukfSZ5NO64RwCk8URaILqEkUzL2Pv5/kOIK66KkLtki5udQlEEFax4269P1XJK/FBGI
         TrM+chcXDtqOqLzbdUS6djQiBzOXN++pcX6oOVsw+6+sE6UNJQcQ7YlpRqWZXUsNlQmq
         igyquar8ekjfD1Z6JlgyYv3DQ6cVx7/czxuT9PECsRCKpHerTsZNDZ3BtAhiQlPvJ0G1
         D7YQ==
X-Gm-Message-State: AOAM532/DhfFINtf7A9oaQ6veYfUmeglbBlBgTDDPhGKMz0SFAc1Xfxt
        neQ03EsKRy3B5Bb9utuFnP/v9Yg+zihZIJfM6l02eN3MZ30=
X-Google-Smtp-Source: ABdhPJxjAiGqKqssGBSGjciVuslNVIorU+YzSmPrKCFh6phFNNP2gz5NRAGDmaEa7CMusKb48dEZgOfy25aN1E1JR4k=
X-Received: by 2002:a2e:8e81:: with SMTP id z1mr2285688ljk.316.1606449007502;
 Thu, 26 Nov 2020 19:50:07 -0800 (PST)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 26 Nov 2020 22:49:56 -0500
Message-ID: <CAD56B7cpMcuu_+9bxQ0zCsr489J9Te268aOeQTC32rOeF1hG+A@mail.gmail.com>
Subject: RE: mmc: sdhci-of-arasan: Issue DLL reset explicitly
To:     linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Everyone,

The recent commit d06d60d5 'mmc: sdhci-of-arasan: Issue DLL reset
explicitly' seems to break the eMMC on our zynqmp boards, we get
messages like this:
mmc0: error -110 whilst initialising MMC card
We're using the XCZU2EG-1SFVC784I parts [1]. I see that this is moving
the DLL reset out of ATF. So part of the issue might be that we're
using the 2019.1 ATF version.

thanks,
Paul

[1] Enclustra modules:
https://www.enclustra.com/en/products/system-on-chip-modules/mercury-xu5/
