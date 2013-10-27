From: Chris Ball <cjb@laptop.org>
Subject: Re: [GIT PULL] MMC updates for mmc-next
Date: Sun, 27 Oct 2013 00:11:56 -0400
Message-ID: <87wqkzjqsz.fsf@octavius.laptop.org>
References: <CAPDyKFqtoTqMWeGJeuLt3rFCqEt9uHSYyN1qRX7n+G6UdW7sbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32935 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab3J0EMH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 27 Oct 2013 00:12:07 -0400
In-Reply-To: <CAPDyKFqtoTqMWeGJeuLt3rFCqEt9uHSYyN1qRX7n+G6UdW7sbA@mail.gmail.com> (Ulf
	Hansson's message of "Tue, 22 Oct 2013 14:48:01 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Ulf,

On Tue, Oct 22 2013, Ulf Hansson wrote:
> Hi Chris,
>
> I have been posting some various patchsets to the mmc-list since early
> September. This pull request collects the patches for you to pull in
> to your mmc tree for the mmc-next branch. I hope you find this
> convenient.
>
> Kind regards
> Ulf Hansson
>
>
> The following changes since commit 26cb3023896d8b188db0000328e39a7cdb92c0a4:
>
>   mmc: sdhci: Use jiffies instead of a timeout counter (2013-10-21
> 15:58:47 -0400)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/ulfh/mmc.git mmc-next_for_chris
>
> for you to fetch changes up to 5d6f3429bc44f653a0b58d8255532705d40d40e0:
>
>   mmc: core: Add MMC_CAP_RUNTIME_RESUME to resume at runtime_resume
> (2013-10-22 12:39:40 +0200)

Thanks very much, looks good -- pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
