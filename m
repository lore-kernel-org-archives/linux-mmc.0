From: Michael Shigorin <mike@altlinux.org>
Subject: Re: [PATCH] mmc: card: not access RPMB partition for normal read and write
Date: Wed, 1 Oct 2014 17:53:30 +0400
Message-ID: <20141001135330.GB15863@imap.altlinux.org>
References: <1407816090-7671-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pegasus3.altlinux.org ([194.107.17.103]:33465 "EHLO
	pegasus3.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaJANxc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 09:53:32 -0400
Content-Disposition: inline
In-Reply-To: <1407816090-7671-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, 759656@bugs.debian.org, Nell Hardcastle <nell@dev-nell.com>

	Hello,
what is the status of this patch to cope with MMC RPMB?
http://permalink.gmane.org/gmane.linux.kernel.mmc/28281

I had to use this workaround having run into timeouts:
https://dev-nell.com/rpmb-emmc-errors-under-linux.html

Here's some arch/arm work by Ulf:
https://patches.linaro.org/17128/

TIA :)

--=20
=9A---- WBR, Michael Shigorin / http://altlinux.org
=9A=9A------ http://opennet.ru / http://anna-news.info
