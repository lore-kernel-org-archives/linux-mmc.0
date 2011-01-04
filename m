From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/4] mmc: add MMC_QUIRK_DISABLE_CD
Date: Wed, 5 Jan 2011 01:22:23 +0200
Message-ID: <AANLkTi=oEm2cqWQoAw9h8E8g6gr0wdn96LjS_55J-r2K@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-3-git-send-email-ohad@wizery.com> <4D239AAF.6090202@csr.com>
 <AANLkTikKDkE8eoRct_DN++dRTZ8uEMqUKN2GZdCngRKQ@mail.gmail.com>
 <AANLkTinEWsYBqgchwbjT2ZnoVYPcibJDF2Jt3v1AysUt@mail.gmail.com> <4D23A794.8020106@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:56372 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1ADXWp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 18:22:45 -0500
Received: by iyf40 with SMTP id 40so6847948iyf.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 15:22:44 -0800 (PST)
In-Reply-To: <4D23A794.8020106@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Jan 5, 2011 at 1:04 AM, David Vrabel <david.vrabel@csr.com> wrote:
> Could we unconditionally disable the card's internal pull-up?

Good question. Empirically, I can say that we have done this with many
types of boards and never encountered any issue.
