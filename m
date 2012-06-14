From: Leon Romanovsky <leon@leon.nu>
Subject: Re: power class selection fails on 3.5-rc1
Date: Thu, 14 Jun 2012 15:32:45 +0300
Message-ID: <CALq1K=KNvJYi_EnzgiU6Q-+spzuyWVSXf-zT7fQR55BJ5vcJvg@mail.gmail.com>
References: <6008680.IROCjD91iZ@ax5200p> <4FCDFD3E.9020804@stericsson.com>
 <000301cd43c9$05745550$105cfff0$@codeaurora.org> <1577823.5RM6MKofop@ax5200p>
 <000701cd4497$9035d550$b0a17ff0$@codeaurora.org> <CAGxe1ZGLfETh5N2YkSOhe0OhpD_pjro=C00SwXrdVhq7AKAEYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37803 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab2FNMdH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 08:33:07 -0400
Received: by eeit10 with SMTP id t10so553755eei.19
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jun 2012 05:33:06 -0700 (PDT)
In-Reply-To: <CAGxe1ZGLfETh5N2YkSOhe0OhpD_pjro=C00SwXrdVhq7AKAEYA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, Marc Dietrich <marvin24@gmx.de>, Ulf Hansson <ulf.hansson@stericsson.com>, saugata.das@linaro.org, linux-mmc@vger.kernel.org

Hi Girish,

On Fri, Jun 8, 2012 at 2:46 PM, Girish K S
<girish.shivananjappa@linaro.org> wrote:
> Today i tried om the eMMC 4.5 sample.

Please note that according CSD register, this is eMMC 4.41 revision:
192     5       0x05    5       0x05

--
Leon Romanovsky | Independent Linux Consultant
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0www.leon.nu=C2=A0| leon@leon.nu
