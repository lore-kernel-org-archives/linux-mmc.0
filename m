From: Chris Ball <chris@printf.net>
Subject: Re: [RFC PATCH 1/1 v7]mmc: Support-FFU-for-eMMC-v5.0
Date: Tue, 01 Jul 2014 01:34:29 +0100
Message-ID: <868uodnch6.fsf@void.printf.net>
References: <FDD07FEB422EF948A392FDC201AEEAE648AFA7EE@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANEJEGu9PYi5DxuEWBwEHjUqWt2J-sEDZMKLwvZTUBdUnK=7XA@mail.gmail.com>
	<CANEJEGs2dAA0DSZfwYcV8nZn4Z1+MqAa0bJZocTZT5zjXe_dDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38192 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbaGAAeg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jun 2014 20:34:36 -0400
In-Reply-To: <CANEJEGs2dAA0DSZfwYcV8nZn4Z1+MqAa0bJZocTZT5zjXe_dDQ@mail.gmail.com>
	(Grant Grundler's message of "Mon, 30 Jun 2014 16:35:05 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Olof Johansson <olofj@chromium.org>

Hi Grant, sorry about the delay.

On Tue, Jul 01 2014, Grant Grundler wrote:
> ping? Another week is past.
>
> I know you guys are busy with other stuff. But please at least publish
> what you think the next steps for this patch are.
>
> This is a critical patch for supporting eMMC products and adding
> additional support for other vendors. I'd like to continue working
> with "upstream" and the lack of response in this case is making this
> unnecessarily difficult.

It's tough to merge a significant patch that you haven't tested and we
haven't tested.  We could do it, though -- I'd like to hear what Ulf
thinks.  Please could you give a quick explanation of why doing this
in kernel-space makes more sense than using your mmc-utils version?

Thanks,

- Chris.
-- 
Chris Ball   <http://printf.net/>
