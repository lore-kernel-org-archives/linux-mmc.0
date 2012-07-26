From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 1/2] block: ioctl support for sanitize in eMMC 4.5
Date: Thu, 26 Jul 2012 13:36:31 +0000
Message-ID: <201207261336.32018.arnd@arndb.de>
References: <1343208766-8046-1-git-send-email-ygardi@codeaurora.org> <1343208766-8046-2-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343208766-8046-2-git-send-email-ygardi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 25 July 2012, Yaniv Gardi wrote:
> 
> Adding a new ioctl to support sanitize operation in eMMC
> cards version 4.5.
> The sanitize ioctl support helps performing this operation
> via user application.
> 
> Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
> 

Can you explain how you expect this to be called by a file system?
We've debated this in the past and concluded that we probably
want to do it at the same time as batched discard, but I don't
see if the sanitize request should be sent for each FITRIM
or whether we should better have a separate file system level
ioctl. My feeling is that it would be more useful to call this
feature through a file system level ioctl than through a block
level ioctl, but I guess it makes sense to support both.

	Arnd
