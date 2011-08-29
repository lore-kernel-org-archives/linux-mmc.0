From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Mon, 29 Aug 2011 12:06:23 +0530
Message-ID: <CANYdXnpUmZJCQBmpPcM73CoJJHc05YOrdAGXALN+bsJW6o5hcg@mail.gmail.com>
References: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
	<m28vqdzaxw.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49492 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab1H2GgY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2011 02:36:24 -0400
Received: by gya6 with SMTP id 6so4536501gya.19
        for <linux-mmc@vger.kernel.org>; Sun, 28 Aug 2011 23:36:24 -0700 (PDT)
In-Reply-To: <m28vqdzaxw.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi Chris,
  The git repo that I have cloned is
git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git and created
my branch against it.Now when I create a patch and apply the patch
directly.It works fine .If I mail the patch and do a copy-paste to a
text file and try to apply ,I get some errors saying  Hunk #1 FAILED
at 764,etc. Can you help me on this on how to go about ?


On Sun, Aug 28, 2011 at 11:16 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Shashidhar,
>
> On Tue, Aug 23 2011, Shashidhar Hiremath wrote:
>> The Patch adds the support for SDIO interrupts for all slots.
>> It includes enabling of SDIO interrupts through dw_mci_enable_sdio_i=
rq
>> and the handling of the slot specific interrupts in the Interrupt Se=
rvice
>> Routine.
>
> Please send a v3 patch that:
> =A0* is not corrupt (the line starting "@@ -1249,6" is broken by a ne=
wline)
> =A0* applies against mmc-next.
>
> Then I'll apply it for 3.2. =A0 Thanks!
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
regards,
Shashidhar Hiremath
