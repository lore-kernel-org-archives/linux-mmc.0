From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1] mmc: Support of SDIO irq for dw_mmc
Date: Mon, 29 Aug 2011 10:12:53 -0400
Message-ID: <m27h5wxq56.fsf@bob.laptop.org>
References: <CANYdXnqfBP74Xi1SuWJh3pjrZ4h7hjrc7xE+vXL0Bw41xEbVUw@mail.gmail.com>
	<m28vqdzaxw.fsf@bob.laptop.org>
	<CANYdXnpUmZJCQBmpPcM73CoJJHc05YOrdAGXALN+bsJW6o5hcg@mail.gmail.com>
	<CAAG0J9-MhApCtqOm-x3y_BNKU-eX3G8fkZSxF43je6P6Gt=0cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59080 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab1H2OO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2011 10:14:26 -0400
In-Reply-To: <CAAG0J9-MhApCtqOm-x3y_BNKU-eX3G8fkZSxF43je6P6Gt=0cw@mail.gmail.com>
	(James Hogan's message of "Mon, 29 Aug 2011 07:47:44 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi,

On Mon, Aug 29 2011, James Hogan wrote:
> On 29 August 2011 07:36, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com> wrote:
>> Hi Chris,
>> =C2=A0The git repo that I have cloned is
>> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git and create=
d
>> my branch against it.Now when I create a patch and apply the patch
>> directly.It works fine .If I mail the patch and do a copy-paste to a
>> text file and try to apply ,I get some errors saying =C2=A0Hunk #1 F=
AILED
>> at 764,etc. Can you help me on this on how to go about ?
>
> See Documentation/email-clients.txt for details.

Also, make sure to run "git checkout mmc-next" after cloning.
The master branch is just Linus' own tree.

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
