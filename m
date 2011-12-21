From: Dmitry Antipov <dmitry.antipov@linaro.org>
Subject: Re: [PATCH] mmc: use usleep_range() in mmc_delay()
Date: Wed, 21 Dec 2011 17:05:02 +0400
Message-ID: <4EF1D97E.3000201@linaro.org>
References: <4EF18310.6080801@linaro.org> <4EF1C230.6060005@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52346 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab1LUNE2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2011 08:04:28 -0500
In-Reply-To: <4EF1C230.6060005@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/21/2011 03:25 PM, Sujit Reddy Thumma wrote:

> I have posted similar patch some time back.
> http://comments.gmane.org/gmane.linux.ports.arm.msm/2119.
>
> Would you like to comment on that?

- I believe we should forget about jiffies, HZ and other similar obsolete
   timekeeping stuff;

- I have no ideas where did you get 'most typical' 20 ms. MMC subsystem uses
   mmc_delay() with two compile-time fixed values 1 and 10 ms, with the only
   exception of card-dependent sleep/awake timeout. I was unable to find a table
   with typical values, but it's rounded up to >= 1 ms anyway.

Dmitry
