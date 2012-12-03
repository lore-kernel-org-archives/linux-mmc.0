From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v3 1/4] mmc: dw-mmc: relocate the position called dw_mci_setup_bus()
Date: Mon, 3 Dec 2012 10:33:40 +0000
Message-ID: <CAFbHwiQ18QahcxnLE0UK7G4s8thnvX=5eGikpv+M2akSihe0XQ@mail.gmail.com>
References: <509B6ED1.7030707@samsung.com>
	<001401cdcc74$f20d6850$d62838f0$%jun@samsung.com>
	<50B55068.10709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36851 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2LCKdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Dec 2012 05:33:41 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2104899lag.19
        for <linux-mmc@vger.kernel.org>; Mon, 03 Dec 2012 02:33:40 -0800 (PST)
In-Reply-To: <50B55068.10709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, James Hogan <James.Hogan@imgtec.com>

On Tue, Nov 27, 2012 at 11:44 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> On 11/27/2012 04:58 PM, Seungwon Jeon wrote:
>> On Thursday, November 08, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> To ensure the stable clock need to enable before set the DW_MMC_CARD_NEED_INIT flag.
>>> If set DW_MMC_CARD_NEED_INIT flag, wait for 80-clock before first command after power-up.
>> As we have discussed, the location of 'dw_mci_setup_bus' seems proper in 'dw_mci_set_ios'.
>> But commit message doesn't really hit me. Origin code can also ensure the same.
>> Mr. Newton, do you have any opinion?
> Origin code also ensure it. But it need to setup into set_ios.
> Because Operation related with clock is used with mmc_set_ios().
> And I didn't know why called the dw_mci_setup_bus() at every request.
>
> Best Regards,
> Jaehoon Chung

This looks ok to me (sorry for the delay, I've been away).

Acked-by: Will Newton <will.newton@imgtec.com>
