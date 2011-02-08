From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v4] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Tue, 8 Feb 2011 10:29:06 +0000
Message-ID: <AANLkTikTxjbkA9d9WjVNm9bC3bPLQDndwSXCxp3jOLKS@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTik7cMwgwXR1zK44HXC+1YtzpU3_zW2GUjcBMi8X@mail.gmail.com>
	<4D354752.3030401@samsung.com>
	<AANLkTi=SEXYk9B6N6RGmLKAx_QF6sybgHMVVpEo8mcp8@mail.gmail.com>
	<4D50E4DD.4030500@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D50E4DD.4030500@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 8, 2011 at 6:38 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Will..
>
> I need your help for your code..
>
> In dw_mmc.h, exist some function pointer..
>
> int *get_ro(u32 slot_id);
> int *get_cd(u32 slot_id);
> ...
>
> Just only need slot_id??
> If i need the "struct dw_mci", could i append the parameter?

Yes, that should be possible. However I would like to reduce the
number of places the whole struct dw_mci
is passed around if possible, as the whole struct is usually not
needed and it exposes some driver internals.

Which part of struct dw_mci do you need in the callback?
