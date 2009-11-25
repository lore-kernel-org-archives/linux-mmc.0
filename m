From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v2] [mmc/host]:Blackfin SD Host Controller Driver
Date: Wed, 25 Nov 2009 01:06:49 -0500
Message-ID: <8bd0f97a0911242206u535b829u1c9fbc8a2c0f12a0@mail.gmail.com>
References: <1259148311-31724-1-git-send-email-cliffcai.sh@gmail.com>
	<8bd0f97a0911241951o5394972dl65c48371f4149b7d@mail.gmail.com>
	<da1989290911241958o88d49a8i14a2c9b39f1f101b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:48577 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZKYGHD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2009 01:07:03 -0500
In-Reply-To: <da1989290911241958o88d49a8i14a2c9b39f1f101b@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cliff Cai <cliffcai.sh@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cliff.cai@analog.com

On Tue, Nov 24, 2009 at 22:58, Cliff Cai wrote:
> On Wed, Nov 25, 2009 at 11:51 AM, Mike Frysinger wrote:
>> On Wed, Nov 25, 2009 at 06:25, =C2=A0<cliffcai.sh@gmail.com> wrote:
>>> From: Cliff Cai <cliffcai.sh@gmail.com>
>>>
>>> v2-v1 change:remove mmc host before releasing it in sdh_probe().
>>>
>>> Signed-off-by: Cliff Cai <cliffcai.sh@gmail.com>
>>> ---
>>
>> changelog info should be below the ---, not above.
>
> is this true?

things above the --- are the changelog and go into the git commit.
things below are transient notes for people looking at the patches.
-mike
