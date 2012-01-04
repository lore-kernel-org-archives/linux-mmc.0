From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: deactivate tuning timer when host is suspending
Date: Tue, 03 Jan 2012 20:24:36 -0500
Message-ID: <m2y5tofeej.fsf@bob.laptop.org>
References: <1324959750-18203-1-git-send-email-aaron.lu@amd.com>
	<m2hb0dpsa4.fsf@bob.laptop.org> <20120104011439.GA12195@ladygaga>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33239 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614Ab2ADBYr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jan 2012 20:24:47 -0500
In-Reply-To: <20120104011439.GA12195@ladygaga> (Aaron Lu's message of "Wed, 4
	Jan 2012 09:14:39 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Tue, Jan 03 2012, Aaron Lu wrote:
> I'm sorry Chris, this patch is deprecated and please apply the following
> patch with Adrian's ack instead:
> [PATCH 1/2] mmc: sdhci: Fix tuning timer incorrect setting when suspending host

Okay -- I've pushed that one instead, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
