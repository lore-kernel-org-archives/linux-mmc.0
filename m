From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
Date: Mon, 19 Dec 2011 13:30:42 +0800
Message-ID: <CAN1soZzDR-iH8mkiDaugZ1bo+=fj6MDYxUEh92Pu52XaMDepPw@mail.gmail.com>
References: <87r51fwxgt.fsf@laptop.org>
	<1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<874nxkmaky.fsf@laptop.org>
	<m2sjklfmuf.fsf@bob.laptop.org>
	<CAN1soZxmKct+qGUE2_W+FZufR+gcYZu6Dsj+TkJ06PaO8rV-TQ@mail.gmail.com>
	<4EEEC3BF.6010708@einfochips.com>
	<CAN1soZxnSsZ8SDp=ueu0iMaz59pq7p09DoYD27qCridrrAkmuw@mail.gmail.com>
	<8B50F2A0-3991-4127-B3D9-5D69C70F87EF@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57202 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1LSFan (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 00:30:43 -0500
Received: by vbbfc26 with SMTP id fc26so3745995vbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Dec 2011 21:30:42 -0800 (PST)
In-Reply-To: <8B50F2A0-3991-4127-B3D9-5D69C70F87EF@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jason Chagas <CHAGAS@marvell.com>

On Mon, Dec 19, 2011 at 1:24 PM, Philip Rakity <prakity@marvell.com> wrote:
>
> Haojian,
>
> Should the APMU definitions be moved to a separate include for pxa168 and say given the name pxa168_apmu.h ?
>
> Same comment applies to all the register set since they are not really common.
>
> Philip

I think it's unnecessary to create a new apmu.h. We can distinguish
them by name in macro, as PXA168/MMP2.

Thanks
Haojian
