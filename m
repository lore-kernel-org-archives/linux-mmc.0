From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 09/27] mmc: mmci: modify dma_setup callback
Date: Mon, 1 Oct 2018 11:43:12 +0200
Message-ID: <f47e4e0e-2e6a-2de0-ecb6-488d00fb1115@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-10-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFq-KUNuftT1F7TXMU-Jceqi9GYTWC4Jb7qn3UdpXHR+9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq-KUNuftT1F7TXMU-Jceqi9GYTWC4Jb7qn3UdpXHR+9Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

hi Ulf

On 10/01/2018 11:30 AM, Ulf Hansson wrote:
> On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch creates a generic mmci_dma_setup which calls
>> dma_setup callback and manages common next_cookie.
>> This patch is needed for sdmmc variant which has a different
>> dma settings.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>
>> # Conflicts:
>> #       drivers/mmc/host/mmci.h
>>
> 
> Please remove this. Looks like some of the other patches in the series
> have this in their changelogs as well, please have a look and fix them
> all.
> 

yes, it's a mistake due to rush work (like Version of cover letter).
sorry

BR
Ludo

> [...]
> 
> Kind regards
> Uffe
> 
