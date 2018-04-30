From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: Re: [RESEND PATCH v4.9, 1/1] mmc: sdhci-dwc-mshc-pci: synopsys dwc
 mshc support
Date: Mon, 30 Apr 2018 07:23:41 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A9AAB68@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A99DD80@IN01WEMBXB.internal.synopsys.com>
 <2f51bbdb-6d1e-8e8e-d6d5-96270a47dd56@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,=0A=
=0A=
Yes, this patch was meant for linux stable. Thank you pointing me the=0A=
corresponding rules.=0A=
=0A=
We are planning to port our driver to mainline. We will submit the patch=0A=
for mainline when it's ready.=0A=
=0A=
Thanks,=0A=
Prabu=0A=
=0A=
On 4/26/2018 3:27 PM, Adrian Hunter wrote:=0A=
> On 12/04/18 18:47, Prabu Thangamuthu wrote:=0A=
>> This patch is intended for linux-4.9.y branch.=0A=
> Do you mean linux stable?  That means you need to follow stable kernel ru=
les:=0A=
>=0A=
> 	https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_torvalds_linux.git_tree_Documentation_process_stable=
-2Dkernel-2Drules.rst&d=3DDwICaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DHr8lNh6yuL8=
thqr0BTH-LcNHR7jkWxQSt_H5NZCoTxI&m=3DcNM2NjAiX5xnDfckYjMch_0XeHrBjgCHYbcQHj=
kmVn8&s=3DD44hBUjJ0oaWFI_OdPQkcDHl5Ou8XJR7tMYW-H3TOhk&e=3D=0A=
>=0A=
=0A=
