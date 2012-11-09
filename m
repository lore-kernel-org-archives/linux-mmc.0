From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v7 0/3] Add modules to support realtek PCIE card reader
Date: Fri, 9 Nov 2012 23:07:17 +0800
Message-ID: <509D1C25.9040909@realsil.com.cn>
References: <cover.1351481260.git.wei_wang@realsil.com.cn> <508F4A88.8010207@realsil.com.cn> <87r4o56w1f.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r4o56w1f.fsf@octavius.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "oakad@yahoo.com" <oakad@yahoo.com>, "bp@alien8.de" <bp@alien8.de>
List-Id: linux-mmc@vger.kernel.org

=E4=BA=8E 11/08/2012 03:41 AM, Chris Ball =E5=86=99=E9=81=93:
> Hi,
>
> On Mon, Oct 29 2012, wwang wrote:
> I'm happy with the MMC portion.  I think we're mainly waiting for the
> MFD patch -- Samuel, do you have any remaining review comments that n=
eed
> to be fixed?
>
> Thanks,
>
> - Chris.

Hi Chris:

I have noticed that the file rtsx_pci_sdmmc.c in your mmc-next branch i=
s=20
still v6 patch.  In v7 patch, this MMC part has also been modified to=20
comply with my MFD portion.  So please update to this version.

And one more question. Samuel have merged all of my patch set in his=20
for-next branch, including the MMC part.  I don't know whether this wil=
l=20
conflict with your tree in the next merge.

Hi Samuel:

Since the whole patch set has been merged in your for-next branch, does=
=20
it mean that you will help to merge all of the three parts to linus's t=
ree?

Thank you!
Wei WANG
