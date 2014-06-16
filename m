From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
Date: Mon, 16 Jun 2014 15:41:11 -0700
Message-ID: <CALAqxLXQeYA8jt_hLrJSuWtt7j3t2iZSZjEVAX7ScODAgrmVbA@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
	<CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
	<CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33428 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbaFPWlM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 18:41:12 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy4so5667304vcb.33
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 15:41:11 -0700 (PDT)
In-Reply-To: <CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Peter Maydell <peter.maydell@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On Mon, Jun 16, 2014 at 2:20 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This patch based upon my latest mmc tree and the next branch. I tried
> to apply it for 3.15, and I think you will be able resolve the
> conflict - I should be quite trivial.

No worries. I just didn't want to waste time resolving it if it was
logically dependent on some other change.

I'll give it a shot and get back to you.

thanks
-john
