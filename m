From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: core: Use delayed work in clock gating framework
Date: Wed, 9 Nov 2011 14:58:03 +0100
Message-ID: <CACRpkdZHFvJBVU0fZoj0Gu44oLiF5LzXOiHh0yC0-0cjyCL2og@mail.gmail.com>
References: <1319699643-30700-1-git-send-email-sthumma@codeaurora.org>
	<4EBA04BC.2010507@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39307 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab1KIN6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2011 08:58:04 -0500
In-Reply-To: <4EBA04BC.2010507@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-msm@vger.kernel.org, cjb@laptop.org

On Wed, Nov 9, 2011 at 5:42 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:
> On 10/27/2011 12:44 PM, Sujit Reddy Thumma wrote:
>>
>> Current clock gating framework disables the MCI clock as soon as the
>> request is completed and enables it when a request arrives. This
>> aggressive
>> clock gating framework, when enabled, cause following issues:
>> (...)
>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>
>> ---
>> Changes in v2:
>> =A0 =A0 =A0 =A0- support for tuning delay via sysfs entry.
>
> Linus/Chris, any comments on this V2 version?

Yes! This:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Sujit,
Linus Walleij
