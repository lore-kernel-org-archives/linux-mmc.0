From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 0/2] dw_mmc: add multislot support
Date: Thu, 26 Apr 2018 08:28:04 +0200
Message-ID: <CAPDyKFr4WXgFEDLGztRoSrAFMrHC7ASJxaxCTKMeGN8i-Ns86w@mail.gmail.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
 <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com>
 <1524239609.10138.47.camel@synopsys.com> <CAPDyKFpY7JsQukY=E2PRg=iVfmis4i1kvST+b2wtshNc5Jn+jw@mail.gmail.com>
 <1524664417.18209.16.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524664417.18209.16.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "kgene@kernel.org" <kgene@kernel.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

> A bit remark for better understanding:
>
> All card settings change are serialized too. These settings are applied
> after slot switch before execution of new request for this slot.
>
> So situations like calling any host_0 ops while another host (host_1) is active
> are handled by current code.
>
> This is example of simultaneous ops calls for both slots:
>
> host (slot) 0    | host (slot) 1
> -----------------------------------
> h0->set_ios()    |    h1->set_ios()
> h0->request()    |    h1->request()
> h0->set_ios()    |    h1->set_ios()
> h0->request()    |    h1->request()
> h0->request()    |
> h0->request()    |
> h0->request()    |
>
> How it will be serialized in the mmc driver:
>
> h0->set_ios()   // h0 settings save
> h1->set_ios()   // h1 settings save
> h0->request()   // apply settings for h0 and do request

This doesn't work as it would mean violation of the specs in some
scenarios. Particular during the card initialization and card power
off.

> ------ slot switch to h1 ------
> h1->request()   // apply settings for h1 and do request

Ditto. Etc...

> h0->set_ios()   // h0 settings save
> h1->set_ios()   // h1 settings save
> ------ slot switch to h0 ------
> h0->request()   // apply settings for h0 and do request
> ------ slot switch to h1 ------
> h1->request()   // apply settings for h1 and do request
> ------ slot switch to h0 ------
> h0->request()   // do request (no new settings to apply)
> h0->request()   // do request (no new settings to apply)
> h0->request()   // do request (no new settings to apply)
>

Kind regards
Uffe
