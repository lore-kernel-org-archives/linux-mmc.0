From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/8] cross-compiling, SEND_STATUS, pretty-printing and enhanced user area
Date: Thu, 27 Jun 2013 11:11:28 -0400
Message-ID: <87y59vpp0f.fsf@octavius.laptop.org>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59550 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab3F0PLd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:11:33 -0400
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca> (Ben Gardiner's
	message of "Thu, 30 May 2013 17:12:43 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: linux-mmc@vger.kernel.org

Hi Ben,

On Thu, May 30 2013, Ben Gardiner wrote:
> This series builds on top of f74dfe23cd00894aa9f235374468e05acb793e17.
>
> It introduces:
>  * some Makefile changes to make cross-compiling easier
>  * SEND_STATUS
>  * 'pretty'-printing sizes of some fields in KiB
>  * setting the OTP enhanced user area parameters

Thanks for doing this!  I've pushed the whole patchset to mmc-utils,
after adding an extra warning about the OTP fuse in the usage message.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
