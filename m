From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: modify quirks bit-shift control
Date: Wed, 16 Feb 2011 09:58:44 +0000
Message-ID: <AANLkTik=GivKq8MRHdK9CFNhH-BOs9CiU=1Jt2QEuxBF@mail.gmail.com>
References: <4D5B6C70.2030809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46725 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab1BPJ6p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 04:58:45 -0500
Received: by gwj20 with SMTP id 20so512922gwj.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 01:58:44 -0800 (PST)
In-Reply-To: <4D5B6C70.2030809@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Wed, Feb 16, 2011 at 6:19 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> If we need some quirks, maybe add quirks in future
> But now, quirks value set to integer..later we should be confused..
> So i think that need bit-shift control.
>
> And If we need not any quirks, we didn't set anything..
> (Need not DW_MCI_QUIRK_NONE)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Will Newton <will.newton@imgtec.com>
