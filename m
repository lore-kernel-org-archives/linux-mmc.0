From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: Revert the sdr_timing assignment
Date: Fri, 08 Nov 2013 14:29:24 -0500
Message-ID: <87txfmwv3f.fsf@octavius.laptop.org>
References: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
	<871u37l9p0.fsf@octavius.laptop.org>
	<CAKuRcOKti_ET=9gXGH-Jm8=TYnxag5Cu+wBZ9Hr8nMk=JDiKqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33519 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757557Ab3KHT3g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Nov 2013 14:29:36 -0500
In-Reply-To: <CAKuRcOKti_ET=9gXGH-Jm8=TYnxag5Cu+wBZ9Hr8nMk=JDiKqA@mail.gmail.com>
	(Yuvaraj Kumar's message of "Mon, 28 Oct 2013 10:48:10 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, thomas.ab@samsung.com, Grant Grundler <grundler@chromium.org>, Doug Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Hi Yuvaraj,

On Mon, Oct 28 2013, Yuvaraj Kumar wrote:
> On Sun, Oct 27, 2013 at 8:08 AM, Chris Ball <cjb@laptop.org> wrote:
>> Hi Yuvaraj,
>>
>> On Tue, Oct 22 2013, Yuvaraj Kumar C D wrote:
>>> commit 4ad602c9df1e3b04979c260b5612141b4b892257 was wrongly assigning
>>> ddr_timing value to sdr_timing.This patch fix's this by reverting
>>> the sdr_timing assignment statement to the earlier location.
>>
>> 4ad602c9df1e3 doesn't exist in mainline.  Do you mean e6c784eded7b3
>> ("mmc: dw_mmc: exynos: move the exynos private init")?
> Yes Chris, thats the one.
> Do you want me to respin this patch with the updated commit message?

No, that's okay, I fixed it and pushed to mmc-next for 3.13.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
