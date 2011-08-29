From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Mon, 29 Aug 2011 07:47:44 +0100
Message-ID: <CAAG0J9-MhApCtqOm-x3y_BNKU-eX3G8fkZSxF43je6P6Gt=0cw@mail.gmail.com>
References: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
	<m28vqdzaxw.fsf@bob.laptop.org>
	<CANYdXnpUmZJCQBmpPcM73CoJJHc05YOrdAGXALN+bsJW6o5hcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37026 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab1H2Grp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2011 02:47:45 -0400
Received: by vws1 with SMTP id 1so4340347vws.19
        for <linux-mmc@vger.kernel.org>; Sun, 28 Aug 2011 23:47:44 -0700 (PDT)
In-Reply-To: <CANYdXnpUmZJCQBmpPcM73CoJJHc05YOrdAGXALN+bsJW6o5hcg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

On 29 August 2011 07:36, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> Hi Chris,
> =A0The git repo that I have cloned is
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git and created
> my branch against it.Now when I create a patch and apply the patch
> directly.It works fine .If I mail the patch and do a copy-paste to a
> text file and try to apply ,I get some errors saying =A0Hunk #1 FAILE=
D
> at 764,etc. Can you help me on this on how to go about ?

See Documentation/email-clients.txt for details.

Cheers
James

>
>
> On Sun, Aug 28, 2011 at 11:16 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi Shashidhar,
>>
>> On Tue, Aug 23 2011, Shashidhar Hiremath wrote:
>>> The Patch adds the support for SDIO interrupts for all slots.
>>> It includes enabling of SDIO interrupts through dw_mci_enable_sdio_=
irq
>>> and the handling of the slot specific interrupts in the Interrupt S=
ervice
>>> Routine.
>>
>> Please send a v3 patch that:
>> =A0* is not corrupt (the line starting "@@ -1249,6" is broken by a n=
ewline)
>> =A0* applies against mmc-next.
>>
>> Then I'll apply it for 3.2. =A0 Thanks!
>>
>> - Chris.
>> --
>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>> One Laptop Per Child
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> regards,
> Shashidhar Hiremath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
James Hogan
