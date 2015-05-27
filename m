From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Wait for data transfer after response errors
Date: Wed, 27 May 2015 09:52:32 -0700
Message-ID: <CAD=FV=XHHUOTHRbmVOZr3309SDHZGknhnnLHHnF2MZujBnWDAA@mail.gmail.com>
References: <1431964402-27457-1-git-send-email-dianders@chromium.org>
	<CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com>
	<CAD=FV=WPKV78=Wx5qE43+LsVpx_X9KAfKvcXKWy2hZfDoRLi0w@mail.gmail.com>
	<55652383.2020204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36805 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbbE0Qwc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 May 2015 12:52:32 -0400
Received: by igbpi8 with SMTP id pi8so90002703igb.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2015 09:52:32 -0700 (PDT)
In-Reply-To: <55652383.2020204@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Chris Zhong <zyw@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Tue, May 26, 2015 at 6:53 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Have not checked the dw TRM for this change, will do that as soon as I
>>> get access to it.
>>
>> OK, sounds good.  I have some old version of the DesignWare TRM, so
>> possibly something is different in the newer one...
>
> Which version do you have? I also need to check the TRM version.

It is ancient.  It says 2.41a July 2011.  If anyone has the ability to
give me a newer version, I wouldn't object.

-Doug
