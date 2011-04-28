From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
Date: Thu, 28 Apr 2011 14:09:37 -0500
Message-ID: <BANLkTinUo=E+XD+vG1+QQYRjj2E7aHHA2Q@mail.gmail.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-2-git-send-email-andreiw@motorola.com>
	<1303870235-29041-3-git-send-email-andreiw@motorola.com>
	<1303870235-29041-4-git-send-email-andreiw@motorola.com>
	<1303870235-29041-5-git-send-email-andreiw@motorola.com>
	<1303870235-29041-6-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300EB81997F@SAUSEXMBP01.amd.com>
	<BANLkTim3v7DJZfZpZrZDnomiXTDx7WfWtA@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB81998D@SAUSEXMBP01.amd.com>
	<BANLkTikxOMeM9nxo0cbB0HAWSME8Ttq=HQ@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB81A3EB@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:38173 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933394Ab1D1TJk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 15:09:40 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3SJA5fm010467
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 15:10:05 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3SIuudb003628
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 15:10:05 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so3039064wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 12:09:37 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB81A3EB@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "Xu, Suki" <Suki.Xu@amd.com>

On Thu, Apr 28, 2011 at 3:34 AM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
> Hi Andrei,
>
> The controller is able to send Auto CMD23 with your patch.
>
> Thanks,
> Arindam
>

Whoo hoo :-). This just about made my day... Thanks a lot Arindam, I
really appreciate you taking your time to test this out!

So is that an Ack?

A
