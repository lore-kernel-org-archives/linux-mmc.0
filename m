From: Andrei Warkentin <andreiw@motorola.com>
Subject: MMC block quirk support + Toshiba quirks
Date: Fri,  4 Mar 2011 21:21:09 -0600
Message-ID: <1299295274-32130-1-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:35598 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1CEChM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 21:37:12 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p252bQ07007090
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:37:26 -0500 (EST)
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com [209.85.213.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p252bMHB007073
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:37:26 -0500 (EST)
Received: by mail-yw0-f42.google.com with SMTP id 1so1622041ywh.15
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 18:37:10 -0800 (PST)
In-Reply-To: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This is a second version of the patch set that adds MMC block
quirks as well as two workarounds for Toshiba 32nm part issues.

It incorporates feedback from Arnd.

Table of Contents:
[[RFC] 1/5] MMC: Adjust unaligned write accesses.
[[RFC] 2/5] MMC: Add block quirks support.
[[RFC] 3/5] MMC: Toshiba eMMC - Split 8K-unaligned accesses.
[[RFC] 4/5] MMC: Block quirks request adjust support.
[[RFC] 5/5] MMC: Toshiba eMMC - Part reliability improvement.

Thanks,
A
