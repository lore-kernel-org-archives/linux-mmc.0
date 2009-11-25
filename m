From: Cliff Cai <cliffcai.sh@gmail.com>
Subject: Re: [PATCH v2] [mmc/host]:Blackfin SD Host Controller Driver
Date: Wed, 25 Nov 2009 11:58:40 +0800
Message-ID: <da1989290911241958o88d49a8i14a2c9b39f1f101b@mail.gmail.com>
References: <1259148311-31724-1-git-send-email-cliffcai.sh@gmail.com>
	 <8bd0f97a0911241951o5394972dl65c48371f4149b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35429 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934246AbZKYD6e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2009 22:58:34 -0500
In-Reply-To: <8bd0f97a0911241951o5394972dl65c48371f4149b7d@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cliff.cai@analog.com

On Wed, Nov 25, 2009 at 11:51 AM, Mike Frysinger <vapier.adi@gmail.com>=
 wrote:
> On Wed, Nov 25, 2009 at 06:25, =A0<cliffcai.sh@gmail.com> wrote:
>> From: Cliff Cai <cliffcai.sh@gmail.com>
>>
>> v2-v1 change:remove mmc host before releasing it in sdh_probe().
>>
>> Signed-off-by: Cliff Cai <cliffcai.sh@gmail.com>
>> ---
>
> changelog info should be below the ---, not above.

is this true?

> you're also missing the s-o-b's:
> =A0 =A0Signed-off-by: Bryan Wu <cooloney@kernel.org>
> =A0 =A0Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> -mike
>

Ok,I will do it.

Cliff
