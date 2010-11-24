From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v1 0/4]mmc: enable eMMC4.41 new feature background
 operations and HPI
Date: Wed, 24 Nov 2010 17:12:17 +0900
Message-ID: <AANLkTinvfjAZOyuiM2T8Vtj-vxS59P1HNzjKAjPiOzb_@mail.gmail.com>
References: <20101123084309.GA17754@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61236 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0KXIMS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2010 03:12:18 -0500
In-Reply-To: <20101123084309.GA17754@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org, alan@linux.intel.com, arjan@linux.intel.com, hang.yuan@intel.com, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

Hi,

Basic question. Do you have any performance gain or improvement?
In my test environment. no performance gain. Yes I know it's not for
performance improvement.

How to measure or check it has some improvement?
Any ideas?

Thank you,
Kyungmin Park

On Tue, Nov 23, 2010 at 5:43 PM, Chuanxiao Dong
<chuanxiao.dong@intel.com> wrote:
> Hi,
> =A0 =A0 =A0 =A0These patches were enabled eMMC4.41 standard new featu=
re: background
> =A0 =A0 =A0 =A0operations and HPI.
>
> =A0 =A0 =A0 =A0Since these two features are opertional, driver only e=
nable for those
> =A0 =A0 =A0 =A0eMMC card which supports them.
>
> =A0 =A0 =A0 =A0HPI can interrupt both background operations and low p=
riority foreground
> =A0 =A0 =A0 =A0operations. In these patches, only implemented using H=
PI to interrupt
> =A0 =A0 =A0 =A0background operations.
>
> =A0 =A0 =A0 =A0patch1: enable background operations feature for suppo=
rted eMMC card.
> =A0 =A0 =A0 =A0patch2: let eMMC card do background operations when us=
er reqeust queue
> =A0 =A0 =A0 =A0is idle. In this patch, also considered when driver ad=
ded runtime power
> =A0 =A0 =A0 =A0management.
> =A0 =A0 =A0 =A0patch3: enable HPI feature for supported eMMC card.
> =A0 =A0 =A0 =A0patch4: use HPI to interrupt background operations if =
there is user
> =A0 =A0 =A0 =A0request(foreground operations).
>
> Thanks
> Chuanxiao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
