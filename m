From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Thu, 15 Dec 2011 14:08:16 +0100
Message-ID: <4EE9F140.4010505@st.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com> <CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com> <CACRpkda0y7cOR4EfuGLoGnD_PS1gTWqN7UA74=s2mWmEHokQhQ@mail.gmail.com> <4ECA0025.6030700@st.com> <CACRpkda4gf7dpMxzPTjNZZX1mNqS4YMv21w-xC9TFCYot3qRAg@mail.gmail.com> <4EDDAD95.7020500@st.com> <m2vcpkl990.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:57211 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1LONIe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2011 08:08:34 -0500
In-Reply-To: <m2vcpkl990.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Rasmussen <sebras@gmail.com>, linux-mmc@vger.kernel.org

Hi Chris

On 12/13/2011 5:35 PM, Chris Ball wrote:
> Hi Peppe,
> 
> On Tue, Dec 06 2011, Giuseppe CAVALLARO wrote:
>>> I'm all for this patch so it gets visible in debugfs atleast,
>>> since people seem to need to know these things, so take that as an
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Those who want to writ userspace tools can proceed to
>>> implement the proper sysfs interfaces and document them.
>>
>> Hello Chris.
>>
>> Sorry if I disturb you, any news about the patch:
>>
>>     mmc: debugfs: parse ext_csd via debug_fs (v2)
>>
>> Reviewed-by Sebastian and Acked-by Linus?
>>
>> Please let me know if I need to do some other work on this or if it can
>> be considered for mmc-next.
> 
> I'm still leaning towards doing this in userspace instead -- once we
> have a userspace binary that can do this I don't think there'll be any
> reason to keep a debugfs interface for the same thing around, and that
> tells me that we should just avoid merging the debugfs interface and
> move to userspace straight away.
> 
> I'm hoping to get the userspace tools repository running soon.

that sounds good to me. As soon as the tool is available I'll contribute
with these changes.

Let me know

Peppe
> 
> Thanks,
> 
> - Chris.

