From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Tue, 29 Nov 2011 13:47:21 +0200 (IST)
Message-ID: <9dcc3cb061c7f9a0743a627e08685ac4.squirrel@www.codeaurora.org>
References: <4EB11B6B.2010909@samsung.com>
    <CAFEEs1=yF3u-xL6OnEMTfqYx6HgOaePYkhC7iOJi-=z9TjPfmw@mail.gmail.com>
    <CAELcNGQEm073tFsmSgbKzBfx=oYjZDX=EdbgWQOMZEBscsobTw@mail.gmail.com>
    <CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
    <CAELcNGTddwX6HtR5vJ+wQChyN5a=mU3Wbd5Hg_EqY72xR7k8dA@mail.gmail.com>
    <CAFEEs1mKBUqi8HJK3unRh7KMraethMATTTf8Fn6WB2L+ZUqO9g@mail.gmail.com>
    <4EC096A3.4070309@samsung.com>
    <491f3d5b2d7e3949fdba902e1c98e26b.squirrel@www.codeaurora.org>
    <4ED37784.6030004@samsung.com>
    <CAH9JG2WW+yhoqKSUkh7J4hTMic=ZqWicnhk_AwM-G5M6SUKjSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:24763 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab1K2LrV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2011 06:47:21 -0500
In-Reply-To: <CAH9JG2WW+yhoqKSUkh7J4hTMic=ZqWicnhk_AwM-G5M6SUKjSA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Per Forlin <per.lkml@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, svenkatr@ti.com, chuanxiao.dong@intel.com

>>>
>>> First of all protocol state:
>>> ------------------------------
>>> 7.4.57 BKOPS_EN [163]
>>> This field allows the _host_ to indicate to the device if it is
>>> expected
>>> to periodically manually start background operations by writing to the
>>> BKOPS_START field.
>>>
>>> ...In order for the device to know if host is going to periodically
>>> start
>>> background operations, host shall set bit 0 of BKOPS_EN (EXT_CSD byte
>>> [163]) to indicate that it is going to write to BKOPS_START
>>> periodically.
>>> The device may then delay some of its maintenance operations to when
>>> host
>>> writes to BKOPS_START.
>>> ------------------------------
>>>
>>> My card supports BKOPS (by reading Bit 0 of BKOPS_SUPPORT (EXT_CSD byte
>>> [502]), but BKOPS_EN[163] is not set. So I suppose, original code to
>>> set
>>> BKOPS_EN[163] is needed, otherwise card will never delay its
>>> maintenance
>>> operations.
>>
>>
>> Ok...i will add the code for setting BKOPS_EN bit in patch-v4.
> I hope this features are provided from platform data. since it's not
> mandatory for all devices
This feature is mandatory for eMMC v4.5, but it may be enabled only when
card supports BKOPS_SUPPORT[502] is set (and this one depend on device)
Thanks,
Kostya

