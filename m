From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH v2] mmc-utils: add eMMC 5.0 FFU support
Date: Fri, 21 Feb 2014 13:27:16 -0800
Message-ID: <CANEJEGv_mQWUC7OTcKWytFBcadkknsmW=Q-fp=34Oan3YLP8VQ@mail.gmail.com>
References: <1390506264-17107-1-git-send-email-grundler@chromium.org>
	<282CEDFCBC30114F83C499CB8F2ED53337DEF464@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANEJEGv_Rb5oFwkKnGGf_eH0gQ0QpaimmmmFLTkN7m=MF-OUcA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53337E0247E@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35116 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbaBUV1Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2014 16:27:16 -0500
Received: by mail-ob0-f176.google.com with SMTP id gq1so4946834obb.21
        for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2014 13:27:16 -0800 (PST)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED53337E0247E@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Grant Grundler <grundler@chromium.org>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

Chris,
I haven't seen anything else get proposed. If not, can you include
this patch in mmc-utils ToT and use it as a basis to drive the FFU
support conversation forward?

On Sun, Feb 9, 2014 at 1:06 AM, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
> Hi Grant,
>
> We will contribute shortly our FFU implementation code (RFC) , in which we are addressing both issues discussed below:
>
> - FW File size limitation
> - Atomic FFU Process

Did this get posted? my gmail filters might be misconfigured and
prevented me from seeing it.

> However our implementation is in both layers - kernel driver and mmc-utils.

I have no objection to an implementation which requires both kernel
and mmc-utils. I agree addressing those problems would be a Good Thing
(tm).

However, future promises should NOT prevent improving the current state.

And the patch I proposed would work on existing kernels that are being
shipped to run with eMMC 5.0 devices. I'm not referring to ChromeOS
since I can backport changes to those kernels and deliver those to
ChromeOS users within 8 weeks (worst case...best case is usually about
a week). That's not necessarily true for other distributions/builds.

> We will be happy to get your comments.

excellent! :)

thanks,
grant
