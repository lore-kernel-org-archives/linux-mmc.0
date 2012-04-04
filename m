From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don't support UHS modes.
Date: Wed, 04 Apr 2012 09:13:04 -0400
Message-ID: <874nszbpy7.fsf@laptop.org>
References: <1331927657-2849-1-git-send-email-acooper@gmail.com>
	<CAOGqxeWdOjkSTa2N5GwCvGb02zge+66_CT=0u7upznoWVfUCcw@mail.gmail.com>
	<87r4w5ir2k.fsf@laptop.org>
	<B0C59D0E4E9BA24EB5E08604F8E228540423DF0E@sausexdag03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48690 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205Ab2DDNNQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Apr 2012 09:13:16 -0400
In-Reply-To: <B0C59D0E4E9BA24EB5E08604F8E228540423DF0E@sausexdag03.amd.com>
	(Arindam Nath's message of "Wed, 4 Apr 2012 03:46:22 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Alan Cooper <alcooperx@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Girish K S <girish.shivananjappa@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Philip Rakity <prakity@marvell.com>

Hi,

On Tue, Apr 03 2012, Nath, Arindam wrote:
>> > Still hoping for comments on the patch.
>> 
>> Thanks for the reminder; adding a few potential reviewers to CC:.
>
> Acked-by: Arindam Nath <arindam.nath@amd.com>

Thanks, everyone!  Pushed to mmc-next for 3.4 with all of the ACKs.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
