From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: rewrite CLKDIV computation
Date: Wed, 27 Mar 2013 11:00:01 -0700
Message-ID: <CANEJEGuvz5tp6t3MZmeAUt16XLap7tMuws6WxjrcrdDN_5Y=Uw@mail.gmail.com>
References: <1364338202-10311-1-git-send-email-grundler@chromium.org>
	<000b01ce2ae6$249bfb90$6dd3f2b0$%jun@samsung.com>
	<CANEJEGsLqAdZqLV+c59nT97ErdAOSRWTPJpYye7m64_i7ga0rg@mail.gmail.com>
	<87ip4cbu87.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42399 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab3C0SAC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Mar 2013 14:00:02 -0400
Received: by mail-ob0-f179.google.com with SMTP id un3so8466544obb.10
        for <linux-mmc@vger.kernel.org>; Wed, 27 Mar 2013 11:00:01 -0700 (PDT)
In-Reply-To: <87ip4cbu87.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Doug Anderson <dianders@chromium.org>, Will Newton <will.newton@gmail.com>, Bing Zhao <bzhao@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ashok Nagarajan <asnagarajan@chromium.org>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Chris,

On Wed, Mar 27, 2013 at 10:58 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Grant,
...
> Please use the following (standard) syntax in the commit message:
>
> Commit e419990b5e8 ("mmc: dw_mmc: correct the calculation for CLKDIV")
> fixed a bug in CLKDIV computation.  [..]

Ok - I didn't know that was "standard". But easy enough to do.

cheers,
grant
