From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: shift with slot-id for CLKENA register
Date: Tue, 14 Feb 2012 10:30:42 +0000
Message-ID: <CAFbHwiRACA64DqUoT7QhnWj=DdnQKqBxpE2bNSVLEBj-u5qf=A@mail.gmail.com>
References: <4F3A1C3F.4060109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59440 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2BNKan (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2012 05:30:43 -0500
Received: by daed14 with SMTP id d14so5280913dae.19
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2012 02:30:42 -0800 (PST)
In-Reply-To: <4F3A1C3F.4060109@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, James Hogan <james.hogan@imgtec.com>

On Tue, Feb 14, 2012 at 8:33 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> In CLKENA register, can support 16-SD card clocks.
> If support correctly, must shift with slot-id.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks good.

Acked-by: Will Newton <will.newton@imgtec.com>
