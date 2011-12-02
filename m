From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: check for zero length ioctl data
Date: Fri, 02 Dec 2011 09:15:10 -0500
Message-ID: <87vcpzhxg1.fsf@laptop.org>
References: <1322035558-1127-1-git-send-email-johan.rudholm@stericsson.com>
	<87ipm0kvay.fsf@laptop.org>
	<E2E6AC6BFAD06343BA2D97432459C1B6071D93F3BD@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46146 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755408Ab1LBOPF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Dec 2011 09:15:05 -0500
In-Reply-To: <E2E6AC6BFAD06343BA2D97432459C1B6071D93F3BD@EXDCVYMBSTM005.EQ1STM.local>
	(Johan RUDHOLM's message of "Fri, 2 Dec 2011 10:51:49 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan RUDHOLM <johan.rudholm@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Per FORLIN <per.forlin@stericsson.com>, Ulf HANSSON <ulf.hansson@stericsson.com>

Hi Johan,

On Fri, Dec 02 2011, Johan RUDHOLM wrote:
>> Would you be able to share the userspace code that you've been using
>> with this, please?  I'd like to start collecting a repository of
>> userspace code showing common uses of this ioctl.
>
> Yes, I think so. How would you prefer to receive such a contribution -
> as a .tar.gz, a patch, a plain text attachment? Do you have any idea
> where such a repository would live?

Any of these sounds fine, whichever works best for you.  When
the repository exists, I think it will live somewhere like:

git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
