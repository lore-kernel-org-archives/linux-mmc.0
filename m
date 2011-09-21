From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: add sd uhs string for mmc_ios_show
Date: Wed, 21 Sep 2011 14:46:24 -0400
Message-ID: <m239fp3f9b.fsf@bob.laptop.org>
References: <1314950768-7135-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47202 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab1IUSq2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:46:28 -0400
In-Reply-To: <1314950768-7135-1-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Fri, 2 Sep 2011 16:06:08 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com

Hi Aaron,

On Fri, Sep 02 2011, Aaron Lu wrote:
> This is a minor fix. It makes mmc_ios_show print proper string when the
> host's timing is one of the newly added UHS-I modes.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
