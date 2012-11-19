From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc,sdio: Fix the panic due to devname NULL when calling pm_runtime_set_active()
Date: Mon, 19 Nov 2012 10:50:14 +0200
Message-ID: <CAK=WgbaPFC-FaFjzPBPy5kreS4kj6ZAqkH9P85zNqTS0aU=ksQ@mail.gmail.com>
References: <1353070447.15558.1681.camel@cliu38-desktop-build>
 <CAK=WgbYiKFpSeyKZU3OWvbq4VDKRMFQvxwPbyxsBbEYJGQU1sA@mail.gmail.com>
 <27240C0AC20F114CBF8149A2696CBE4A1D4191@SHSMSX101.ccr.corp.intel.com>
 <CAK=WgbYFbewu4bw5fhgjiG83oWiAcmBtRQF3_Jeba0CYKg75Qg@mail.gmail.com> <27240C0AC20F114CBF8149A2696CBE4A1D445F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A1D445F@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 19, 2012 at 10:01 AM, Liu, Chuansheng
<chuansheng.liu@intel.com> wrote:
>> > Rechecked these codes, the trace event runtime_pm_status is added newly,
>> this is different with vanilla
>> > Linux.
>>
>> Not sure I'm following - can you point out which tree are you working with ?
> Sorry, it is added internally for debugging purpose.

Maybe keep this patch internally too then ?
