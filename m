From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/4 v3] mmc: sh_mmcif: process requests asynchronously
Date: Sun, 25 Dec 2011 17:43:04 -0500
Message-ID: <m2aa6gxog7.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
	<1323887514-12650-4-git-send-email-g.liakhovetski@gmx.de>
	<m2boqxz91n.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1112252105340.22951@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1112252105340.22951@axis700.grange> (Guennadi
	Liakhovetski's message of "Sun, 25 Dec 2011 21:07:52 +0100 (CET)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Sun, Dec 25 2011, Guennadi Liakhovetski wrote:
>> This patch (3/4) no longer applies to mmc-next -- mind resending?
>
> This one should be ok.

Seems to be worse, for some reason:

patching file drivers/mmc/host/sh_mmcif.c
Hunk #2 succeeded at 189 (offset -5 lines).
Hunk #3 FAILED at 217.
Hunk #4 succeeded at 503 (offset -4 lines).
Hunk #5 FAILED at 780.
Hunk #6 FAILED at 802.
Hunk #7 FAILED at 835.
Hunk #8 succeeded at 908 (offset 6 lines).
Hunk #9 FAILED at 942.
Hunk #10 succeeded at 1044 with fuzz 2 (offset 11 lines).
Hunk #11 succeeded at 1246 (offset 11 lines).
Hunk #12 succeeded at 1351 (offset 11 lines).
Hunk #13 FAILED at 1376.
Hunk #14 succeeded at 1425 (offset 11 lines).
6 out of 14 hunks FAILED -- saving rejects to file drivers/mmc/host/sh_mmcif.c.rej

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
