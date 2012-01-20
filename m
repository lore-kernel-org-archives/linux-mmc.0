From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v3] ARM: davinci: map default_queue to edma channels
Date: Fri, 20 Jan 2012 16:46:48 +0000
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317970CE@DBDE01.ent.ti.com>
References: <1326956721-25158-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45113 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab2ATQrF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 11:47:05 -0500
In-Reply-To: <1326956721-25158-1-git-send-email-hs@denx.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Schocher <hs@denx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "juha.kuikka@gmail.com" <juha.kuikka@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Wolfgang Denk <wd@denx.de>, Sergei Shtylyov <sshtylyov@mvista.com>

Hi Heiko,

On Thu, Jan 19, 2012 at 12:35:21, Heiko Schocher wrote:
> Default queue is expected to be a low-priority queue.
> This way, long transfers on the default queue started
> by the codec engine will not cause audio defects.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

> Signed-off-by: juha.kuikka@gmail.com
> Reported-by: juha.kuikka@gmail.com

Sign-off should include real name, so I changed these
two lines to:

    Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
    Reported-by: Juha Kuikka <juha.kuikka@gmail.com>

before applying. Let me know if anyone has objections.

Thanks,
Sekhar
