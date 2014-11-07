From: Fabio Estevam <festevam@gmail.com>
Subject: Re: eMMC write error in IMX6 Sabre AI board
Date: Fri, 7 Nov 2014 10:12:12 -0200
Message-ID: <CAOMZO5D1n7JutWCJAVafFSOKPZaS_HJjLPp26ROR-Gk12=b0yw@mail.gmail.com>
References: <loom.20141107T122543-102@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:58928 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaKGMMO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Nov 2014 07:12:14 -0500
Received: by mail-la0-f46.google.com with SMTP id gm9so4330456lab.33
        for <linux-mmc@vger.kernel.org>; Fri, 07 Nov 2014 04:12:12 -0800 (PST)
In-Reply-To: <loom.20141107T122543-102@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: vadivelan mani <vadivelan.mani@toshiba-tsip.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Nov 7, 2014 at 9:35 AM, vadivelan mani
<vadivelan.mani@toshiba-tsip.com> wrote:
> Dear all,
>      I'm facing this unique problem during emmc write operation. I'm using a
> Toshiba emmc device on Sabre AI board and linux kernel version 3.0.35.

Please try 3.18-rc3.
