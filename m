From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: change to use recommended reset procedure
Date: Tue, 13 May 2014 11:13:33 +0100
Message-ID: <5371F04D.7060007@imgtec.com>
References: <1395834374-1988-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAKuRcOJYsC9OUOrYrvKg_iC5Z6dZ0mqW3-y=UXHtCr99=gQBXw@mail.gmail.com>
 <536C2C31.8000209@samsung.com>
 <CAPz6YkXGH96mjeePwUSRmPX4Y1YXYif+N+BRKsTwtNxtRq3xoQ@mail.gmail.com>
 <536C594A.5080107@samsung.com> <536C84A0.6020403@samsung.com>
 <CAPz6YkUjLmWXvoCkuY8vAwLHksf0Uit6gWP-ADWBbN3NDJBo-w@mail.gmail.com>
 <CAPz6YkW5CfdMTW3W-zdK29RCv4q7u9rAMr6AjWip3beuhgsv5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPz6YkW5CfdMTW3W-zdK29RCv4q7u9rAMr6AjWip3beuhgsv5g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sonny Rao <sonnyrao@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, sunil joshi <joshi@samsung.com>, Douglas Anderson <dianders@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Yuvaraj Kumar <yuvaraj.cd@gmail.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 12/05/14 22:44, Sonny Rao wrote:
> Doug mentioned that James Hogan might have an answer.  James, are
> there Imgtec SoCs which use dw_mmc and use DMA but don't use the
> IDMAC?  If so, we can add that support into this reset procedure
> patch.

Yes, the Toumaz TZ1090 SoC has the dw_mmc configured without an IDMAC,
so it uses the IMG DMAC block instead.

Cheers
James
