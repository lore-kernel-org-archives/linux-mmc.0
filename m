From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH v4 1/2] MMC: add support for the Marvell Dove SDHCI controller
Date: Mon, 22 Nov 2010 14:19:45 +0200
Message-ID: <AANLkTi=sy51X-RVvUYBmoWfKfXBy2rWYshFtFMqt-fHh@mail.gmail.com>
References: <cover.1288293593.git.mike@compulab.co.il>
	<ea487c43c1aff1d07355e0e0699e739c8617b96f.1288293593.git.mike@compulab.co.il>
	<AANLkTimhzUe+qODZYCvvrH6Hi06gV1yHVpS1LRHhXu7o@mail.gmail.com>
	<AANLkTin66iEqCgUKUFXGLZg4pu-mv=zb-E+x04BrC-=h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46881 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab0KVMTq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 07:19:46 -0500
Received: by qwc9 with SMTP id 9so740116qwc.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2010 04:19:46 -0800 (PST)
In-Reply-To: <AANLkTin66iEqCgUKUFXGLZg4pu-mv=zb-E+x04BrC-=h@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mike Rapoport <mike@compulab.co.il>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Saeed Bishara <saeed@marvell.com>, linux-arm-kernel@lists.infradead.org

On Mon, Nov 22, 2010 at 12:10 PM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
> On Mon, Nov 22, 2010 at 9:42 AM, saeed bishara <saeed.bishara@gmail.c=
om> wrote:
>> On Thu, Oct 28, 2010 at 9:23 PM, Mike Rapoport <mike@compulab.co.il>=
 wrote:
> ...
>>> + =C2=A0 =C2=A0 =C2=A0 bool "SDHCI support on Marvell's Dove SoC"
> ...
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you have a controller with this in=
terface, say Y or M here.
>
> Just a nitpick: =C2=A0I guess that the "or M" in "say Y or M" is a ty=
po
that's right, Mike, please remove the "or M"
saeed
>
