From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: FW: [PATCH v2] mmc: sdhci: apply voltage range check only for
 non-fixed regulators
Date: Tue, 04 Dec 2012 15:07:34 +0100
Message-ID: <50BE03A6.6010504@samsung.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C060FBEA29A@SC-VEXCH1.marvell.com>
 <CADz5_gLC=z_VYrNq8q3dU7L6im7shSz-Sn6Tzym2mRZONwpgUg@mail.gmail.com>
 <50AB34E2.1010206@samsung.com>
 <CADz5_gKdUq8bjuMr1=yo65ysHzLNvKnrfVuSpLk-Q6ek-TWpNA@mail.gmail.com>
 <50AB587F.3040405@samsung.com>
 <CADz5_gJ1hV3n-4BPgBNT9LDp2-E=vNNzMGx=_9PmzT0RJ9+TsA@mail.gmail.com>
 <50AB81C8.4090300@samsung.com>
 <CADz5_gL3uHbvhb2ccp03=9P88u1Catxe9+Xffs3KmJsZGWmWvA@mail.gmail.com>
 <50AB9B90.1030404@samsung.com> <87hao7f344.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <87hao7f344.fsf@octavius.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Kevin Liu <keyuan.liu@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, Philip Rakity <prakity@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hello,

On 11/30/2012 5:48 PM, Chris Ball wrote:
> On Tue, Nov 20 2012, Marek Szyprowski wrote:
> > The problem with dummy regulator is the fact that it can be enabled only
> > globally for all devices in the system. I think that the best solution
> > would be to introduce regulator_can_change_voltage() as Mark suggested.
> > I will post patches soon.
>
> Does this mean that I shouldn't merge either yours or Kevin's patch for
> 3.8, while we wait for this?  Any ETA on it?

I've just posted an updated patches to solve those issues. I'm sorry for the
delay as I was terribly busy with other stuff. Kevin's patch is still
required and it should stay in the tree because it indeed fixes other, in
some cases related issues.

However my earlier patch "mmc: sdhci: apply voltage range check only for
non-fixed regulators" can be replaced with the new patches from the
"[PATCH v2 0/3] Fix fixed regulators support" thread posted a few minutes
ago (those patches are based on mmc-next branch).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
